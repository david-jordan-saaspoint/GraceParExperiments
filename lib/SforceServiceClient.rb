#!/usr/bin/env ruby
require 'defaultDriver.rb'

endpoint_url = ARGV.shift
obj = Soap.new(endpoint_url)

# run ruby with -d to see SOAP wiredumps.
obj.wiredump_dev = STDERR if $DEBUG

# SYNOPSIS
#   login(parameters)
#
# ARGS
#   parameters      Login - {urn:enterprise.soap.sforce.com}login
#
# RETURNS
#   parameters      LoginResponse - {urn:enterprise.soap.sforce.com}loginResponse
#
# RAISES
#   fault           LoginFault - {urn:fault.enterprise.soap.sforce.com}LoginFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#   fault           InvalidIdFault - {urn:fault.enterprise.soap.sforce.com}InvalidIdFault
#
parameters = nil
puts obj.login(parameters)

# SYNOPSIS
#   describeSObject(parameters)
#
# ARGS
#   parameters      DescribeSObject - {urn:enterprise.soap.sforce.com}describeSObject
#
# RETURNS
#   parameters      DescribeSObjectResponse - {urn:enterprise.soap.sforce.com}describeSObjectResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.describeSObject(parameters)

# SYNOPSIS
#   describeSObjects(parameters)
#
# ARGS
#   parameters      DescribeSObjects - {urn:enterprise.soap.sforce.com}describeSObjects
#
# RETURNS
#   parameters      DescribeSObjectsResponse - {urn:enterprise.soap.sforce.com}describeSObjectsResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.describeSObjects(parameters)

# SYNOPSIS
#   describeGlobal(parameters)
#
# ARGS
#   parameters      DescribeGlobal - {urn:enterprise.soap.sforce.com}describeGlobal
#
# RETURNS
#   parameters      DescribeGlobalResponse - {urn:enterprise.soap.sforce.com}describeGlobalResponse
#
# RAISES
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.describeGlobal(parameters)

# SYNOPSIS
#   describeDataCategoryGroups(parameters)
#
# ARGS
#   parameters      DescribeDataCategoryGroups - {urn:enterprise.soap.sforce.com}describeDataCategoryGroups
#
# RETURNS
#   parameters      DescribeDataCategoryGroupsResponse - {urn:enterprise.soap.sforce.com}describeDataCategoryGroupsResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.describeDataCategoryGroups(parameters)

# SYNOPSIS
#   describeDataCategoryGroupStructures(parameters)
#
# ARGS
#   parameters      DescribeDataCategoryGroupStructures - {urn:enterprise.soap.sforce.com}describeDataCategoryGroupStructures
#
# RETURNS
#   parameters      DescribeDataCategoryGroupStructuresResponse - {urn:enterprise.soap.sforce.com}describeDataCategoryGroupStructuresResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.describeDataCategoryGroupStructures(parameters)

# SYNOPSIS
#   describeLayout(parameters)
#
# ARGS
#   parameters      DescribeLayout - {urn:enterprise.soap.sforce.com}describeLayout
#
# RETURNS
#   parameters      DescribeLayoutResponse - {urn:enterprise.soap.sforce.com}describeLayoutResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#   fault           InvalidIdFault - {urn:fault.enterprise.soap.sforce.com}InvalidIdFault
#
parameters = nil
puts obj.describeLayout(parameters)

# SYNOPSIS
#   describeSoftphoneLayout(parameters)
#
# ARGS
#   parameters      DescribeSoftphoneLayout - {urn:enterprise.soap.sforce.com}describeSoftphoneLayout
#
# RETURNS
#   parameters      DescribeSoftphoneLayoutResponse - {urn:enterprise.soap.sforce.com}describeSoftphoneLayoutResponse
#
# RAISES
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.describeSoftphoneLayout(parameters)

# SYNOPSIS
#   describeTabs(parameters)
#
# ARGS
#   parameters      DescribeTabs - {urn:enterprise.soap.sforce.com}describeTabs
#
# RETURNS
#   parameters      DescribeTabsResponse - {urn:enterprise.soap.sforce.com}describeTabsResponse
#
# RAISES
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.describeTabs(parameters)

# SYNOPSIS
#   create(parameters)
#
# ARGS
#   parameters      Create - {urn:enterprise.soap.sforce.com}create
#
# RETURNS
#   parameters      CreateResponse - {urn:enterprise.soap.sforce.com}createResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#   fault           InvalidIdFault - {urn:fault.enterprise.soap.sforce.com}InvalidIdFault
#   fault           InvalidFieldFault - {urn:fault.enterprise.soap.sforce.com}InvalidFieldFault
#
parameters = nil
puts obj.create(parameters)

# SYNOPSIS
#   update(parameters)
#
# ARGS
#   parameters      Update - {urn:enterprise.soap.sforce.com}update
#
# RETURNS
#   parameters      UpdateResponse - {urn:enterprise.soap.sforce.com}updateResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#   fault           InvalidIdFault - {urn:fault.enterprise.soap.sforce.com}InvalidIdFault
#   fault           InvalidFieldFault - {urn:fault.enterprise.soap.sforce.com}InvalidFieldFault
#
parameters = nil
puts obj.update(parameters)

# SYNOPSIS
#   upsert(parameters)
#
# ARGS
#   parameters      Upsert - {urn:enterprise.soap.sforce.com}upsert
#
# RETURNS
#   parameters      UpsertResponse - {urn:enterprise.soap.sforce.com}upsertResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#   fault           InvalidIdFault - {urn:fault.enterprise.soap.sforce.com}InvalidIdFault
#   fault           InvalidFieldFault - {urn:fault.enterprise.soap.sforce.com}InvalidFieldFault
#
parameters = nil
puts obj.upsert(parameters)

# SYNOPSIS
#   merge(parameters)
#
# ARGS
#   parameters      Merge - {urn:enterprise.soap.sforce.com}merge
#
# RETURNS
#   parameters      MergeResponse - {urn:enterprise.soap.sforce.com}mergeResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#   fault           InvalidIdFault - {urn:fault.enterprise.soap.sforce.com}InvalidIdFault
#   fault           InvalidFieldFault - {urn:fault.enterprise.soap.sforce.com}InvalidFieldFault
#
parameters = nil
puts obj.merge(parameters)

# SYNOPSIS
#   delete(parameters)
#
# ARGS
#   parameters      Delete - {urn:enterprise.soap.sforce.com}delete
#
# RETURNS
#   parameters      DeleteResponse - {urn:enterprise.soap.sforce.com}deleteResponse
#
# RAISES
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.delete(parameters)

# SYNOPSIS
#   undelete(parameters)
#
# ARGS
#   parameters      Undelete - {urn:enterprise.soap.sforce.com}undelete
#
# RETURNS
#   parameters      UndeleteResponse - {urn:enterprise.soap.sforce.com}undeleteResponse
#
# RAISES
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.undelete(parameters)

# SYNOPSIS
#   emptyRecycleBin(parameters)
#
# ARGS
#   parameters      EmptyRecycleBin - {urn:enterprise.soap.sforce.com}emptyRecycleBin
#
# RETURNS
#   parameters      EmptyRecycleBinResponse - {urn:enterprise.soap.sforce.com}emptyRecycleBinResponse
#
# RAISES
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.emptyRecycleBin(parameters)

# SYNOPSIS
#   retrieve(parameters)
#
# ARGS
#   parameters      Retrieve - {urn:enterprise.soap.sforce.com}retrieve
#
# RETURNS
#   parameters      RetrieveResponse - {urn:enterprise.soap.sforce.com}retrieveResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           InvalidFieldFault - {urn:fault.enterprise.soap.sforce.com}InvalidFieldFault
#   fault           MalformedQueryFault - {urn:fault.enterprise.soap.sforce.com}MalformedQueryFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#   fault           InvalidIdFault - {urn:fault.enterprise.soap.sforce.com}InvalidIdFault
#
parameters = nil
puts obj.retrieve(parameters)

# SYNOPSIS
#   process(parameters)
#
# ARGS
#   parameters      C_Process - {urn:enterprise.soap.sforce.com}process
#
# RETURNS
#   parameters      ProcessResponse - {urn:enterprise.soap.sforce.com}processResponse
#
# RAISES
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#   fault           InvalidIdFault - {urn:fault.enterprise.soap.sforce.com}InvalidIdFault
#
parameters = nil
puts obj.process(parameters)

# SYNOPSIS
#   convertLead(parameters)
#
# ARGS
#   parameters      ConvertLead - {urn:enterprise.soap.sforce.com}convertLead
#
# RETURNS
#   parameters      ConvertLeadResponse - {urn:enterprise.soap.sforce.com}convertLeadResponse
#
# RAISES
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.convertLead(parameters)

# SYNOPSIS
#   logout(parameters)
#
# ARGS
#   parameters      Logout - {urn:enterprise.soap.sforce.com}logout
#
# RETURNS
#   parameters      LogoutResponse - {urn:enterprise.soap.sforce.com}logoutResponse
#
# RAISES
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.logout(parameters)

# SYNOPSIS
#   invalidateSessions(parameters)
#
# ARGS
#   parameters      InvalidateSessions - {urn:enterprise.soap.sforce.com}invalidateSessions
#
# RETURNS
#   parameters      InvalidateSessionsResponse - {urn:enterprise.soap.sforce.com}invalidateSessionsResponse
#
# RAISES
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.invalidateSessions(parameters)

# SYNOPSIS
#   getDeleted(parameters)
#
# ARGS
#   parameters      GetDeleted - {urn:enterprise.soap.sforce.com}getDeleted
#
# RETURNS
#   parameters      GetDeletedResponse - {urn:enterprise.soap.sforce.com}getDeletedResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.getDeleted(parameters)

# SYNOPSIS
#   getUpdated(parameters)
#
# ARGS
#   parameters      GetUpdated - {urn:enterprise.soap.sforce.com}getUpdated
#
# RETURNS
#   parameters      GetUpdatedResponse - {urn:enterprise.soap.sforce.com}getUpdatedResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.getUpdated(parameters)

# SYNOPSIS
#   query(parameters)
#
# ARGS
#   parameters      Query - {urn:enterprise.soap.sforce.com}query
#
# RETURNS
#   parameters      QueryResponse - {urn:enterprise.soap.sforce.com}queryResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           InvalidFieldFault - {urn:fault.enterprise.soap.sforce.com}InvalidFieldFault
#   fault           MalformedQueryFault - {urn:fault.enterprise.soap.sforce.com}MalformedQueryFault
#   fault           InvalidIdFault - {urn:fault.enterprise.soap.sforce.com}InvalidIdFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#   fault           InvalidQueryLocatorFault - {urn:fault.enterprise.soap.sforce.com}InvalidQueryLocatorFault
#
parameters = nil
puts obj.query(parameters)

# SYNOPSIS
#   queryAll(parameters)
#
# ARGS
#   parameters      QueryAll - {urn:enterprise.soap.sforce.com}queryAll
#
# RETURNS
#   parameters      QueryAllResponse - {urn:enterprise.soap.sforce.com}queryAllResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           InvalidFieldFault - {urn:fault.enterprise.soap.sforce.com}InvalidFieldFault
#   fault           MalformedQueryFault - {urn:fault.enterprise.soap.sforce.com}MalformedQueryFault
#   fault           InvalidIdFault - {urn:fault.enterprise.soap.sforce.com}InvalidIdFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#   fault           InvalidQueryLocatorFault - {urn:fault.enterprise.soap.sforce.com}InvalidQueryLocatorFault
#
parameters = nil
puts obj.queryAll(parameters)

# SYNOPSIS
#   queryMore(parameters)
#
# ARGS
#   parameters      QueryMore - {urn:enterprise.soap.sforce.com}queryMore
#
# RETURNS
#   parameters      QueryMoreResponse - {urn:enterprise.soap.sforce.com}queryMoreResponse
#
# RAISES
#   fault           InvalidQueryLocatorFault - {urn:fault.enterprise.soap.sforce.com}InvalidQueryLocatorFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#   fault           InvalidFieldFault - {urn:fault.enterprise.soap.sforce.com}InvalidFieldFault
#
parameters = nil
puts obj.queryMore(parameters)

# SYNOPSIS
#   search(parameters)
#
# ARGS
#   parameters      Search - {urn:enterprise.soap.sforce.com}search
#
# RETURNS
#   parameters      SearchResponse - {urn:enterprise.soap.sforce.com}searchResponse
#
# RAISES
#   fault           InvalidSObjectFault - {urn:fault.enterprise.soap.sforce.com}InvalidSObjectFault
#   fault           InvalidFieldFault - {urn:fault.enterprise.soap.sforce.com}InvalidFieldFault
#   fault           MalformedSearchFault - {urn:fault.enterprise.soap.sforce.com}MalformedSearchFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.search(parameters)

# SYNOPSIS
#   getServerTimestamp(parameters)
#
# ARGS
#   parameters      GetServerTimestamp - {urn:enterprise.soap.sforce.com}getServerTimestamp
#
# RETURNS
#   parameters      GetServerTimestampResponse - {urn:enterprise.soap.sforce.com}getServerTimestampResponse
#
# RAISES
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.getServerTimestamp(parameters)

# SYNOPSIS
#   setPassword(parameters)
#
# ARGS
#   parameters      SetPassword - {urn:enterprise.soap.sforce.com}setPassword
#
# RETURNS
#   parameters      SetPasswordResponse - {urn:enterprise.soap.sforce.com}setPasswordResponse
#
# RAISES
#   fault           InvalidIdFault - {urn:fault.enterprise.soap.sforce.com}InvalidIdFault
#   fault           InvalidNewPasswordFault - {urn:fault.enterprise.soap.sforce.com}InvalidNewPasswordFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.setPassword(parameters)

# SYNOPSIS
#   resetPassword(parameters)
#
# ARGS
#   parameters      ResetPassword - {urn:enterprise.soap.sforce.com}resetPassword
#
# RETURNS
#   parameters      ResetPasswordResponse - {urn:enterprise.soap.sforce.com}resetPasswordResponse
#
# RAISES
#   fault           InvalidIdFault - {urn:fault.enterprise.soap.sforce.com}InvalidIdFault
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.resetPassword(parameters)

# SYNOPSIS
#   getUserInfo(parameters)
#
# ARGS
#   parameters      GetUserInfo - {urn:enterprise.soap.sforce.com}getUserInfo
#
# RETURNS
#   parameters      GetUserInfoResponse - {urn:enterprise.soap.sforce.com}getUserInfoResponse
#
# RAISES
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.getUserInfo(parameters)

# SYNOPSIS
#   sendEmail(parameters)
#
# ARGS
#   parameters      SendEmail - {urn:enterprise.soap.sforce.com}sendEmail
#
# RETURNS
#   parameters      SendEmailResponse - {urn:enterprise.soap.sforce.com}sendEmailResponse
#
# RAISES
#   fault           UnexpectedErrorFault - {urn:fault.enterprise.soap.sforce.com}UnexpectedErrorFault
#
parameters = nil
puts obj.sendEmail(parameters)


