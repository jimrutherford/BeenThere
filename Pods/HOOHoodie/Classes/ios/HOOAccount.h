//
// Created by Katrin Apel on 03/03/14.
// Copyright (c) 2014 Hoodie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HOOHoodie;

/**
 * HOOAccount is responsible for the user account management
 */
@interface HOOAccount : NSObject

/**
 * true, when the user is signedIn
 * false, otherwise
 */
@property(nonatomic, assign, readonly) BOOL authenticated;

/**
 * The username of the currently signedIn user. 
 * Is nil when not signedIn or the account is anonymous.
 */
@property(nonatomic, strong) NSString *username;

/**
 * Default initializer.
 * @param hoodie Your HOOHoodie instance
 */
- (id)initWithHoodie:(HOOHoodie *)hoodie;

/**
 * true, when the account of the currently signed in user is anonymous
 * false, otherwise
 */
- (BOOL)hasAnonymousAccount;

/**
 * Checks if there is an existing user on that device and logs in the user automatically.
 * Note: Maybe this shouldn't be a separate function, but the default behavior of HOOHoodie
 */
- (void)automaticallySignInExistingUser:(void (^)(BOOL existingUser, NSError *error))onFinished;

/**
 * Creates an anonymous account.
 * Anonymous means that username and password are generated by Hoodie.
 * The anonymous account can be upgraded later by creating a regular account.
 */
- (void)anonymousSignUpOnFinished:(void (^)(BOOL signUpSuccessful, NSError *error))onSignUpFinished;

/**
 * Creates a regular account with username and password.
 *
 * If the user is already authenticated with an anonymous account, the current account will be upgraded
 * by changing the username / password to the given parameters. No data will be lost.
 *
 * @param username The username must not be empty (or block returns with HOOAccountSignUpUsernameEmptyError) and must be unique (or block returns with HOOAccountSignUpUsernameTakenError)
 * @param password The password can be empty or nil.
 * @param block Is executed, when the sign up is finished. Evaluate signUpSuccessful to see if the sign up was successful and error for the error that occured.
 */
- (void)signUpUserWithName: (NSString *) username
                  password: (NSString *) password
                  onSignUp: (void (^)(BOOL signUpSuccessful, NSError * error))onSignUpFinished;

/**
 * Signs in a user into an existing account.
 *
 * @param username Username for the account.
 * @param password Password for the account.
 * @param block Is executed, when the sign in is finished. Evaluate signInSuccessful to see if the sign in was successful and error for the error that occured. Known errors can be HOOAccountUnconfirmedError, when the account is not yet confirme and HOOAccountSignInWrongCredentialsError if the username/password combination is wrong
 */
- (void)signInUserWithName: (NSString *) username
                  password: (NSString *) password
                  onSignIn: (void (^)(BOOL signInSuccessful, NSError * error))onSignInFinished;


/**
 * Signs out the authenticated user from the account.
 * This will delete all local data.
 * @block
 */
- (void)signOutOnFinished:(void (^)(BOOL signOutSuccessful, NSError *error))onSignOutFinished;


/**
 * Changes the password of the user for the account.
 * The accounts needs to be authenticated / user must be signed in.
 * @param oldPassword The current password of the user. Currently not evaluated.
 * @param newPassword The new password the user wants to set.
 * @param block
 */
- (void)changeOldPassword: (NSString *) oldPassword
            toNewPassword: (NSString *) newPassword
         onPasswordChange: (void (^)(BOOL passwordChangeSuccessful, NSError * error))onPasswordChangeFinished;


@end