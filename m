Return-Path: <SRS0=VzST=RO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB790C43381
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 15:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F4720657
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 15:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YUojW2H7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SRqAkCb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCKPwj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:52:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfCKPwj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Mar 2019 11:52:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2E52460E3F; Mon, 11 Mar 2019 15:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552319557;
        bh=Jq0fVVnotmL5Jw0YiT+wrHMk/gXBkYL3FAW+BV4+O/Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YUojW2H7Wri3Nn2QO8RHan+8pdqkJeLjk1WHQyzTvBaSM5D+RNDG/5RRDYWqnq2SB
         gHZSK7x4pI3ceQlVSUx8mFIZr44l4+ULWDHYQSLhRKrkVhCKnKdzU3yjjKSLoXv+Gj
         EQAkzFGkBz4bYrcUThAJ/b5Gwv4RvTwvvYGXrI6k=
Received: from [10.204.78.89] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7D4760E3F;
        Mon, 11 Mar 2019 15:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552319555;
        bh=Jq0fVVnotmL5Jw0YiT+wrHMk/gXBkYL3FAW+BV4+O/Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SRqAkCb5/6vRc4T5YPTsKzSgP93WHIKLiaSHWfmzD8RWV4us7BupzgTsRju2Ld53Z
         ovHQmV2sQ62fng9YPw6DWH+bNi/92kHRD1CULHqWRMzxts8e9NouSl8NKpv/hGDOU+
         swCDHJSiqCd75yvHwVctvWLELOCxIpues4i28AdE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7D4760E3F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcuupdate: Do a single rhp->func read in
 rcu_head_after_call_rcu
To:     paulmck@linux.ibm.com
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org
References: <1552305483-15846-1-git-send-email-neeraju@codeaurora.org>
 <20190311154839.GH13351@linux.ibm.com>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <f4e04233-c0ef-f592-a4dc-23d659171396@codeaurora.org>
Date:   Mon, 11 Mar 2019 21:22:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190311154839.GH13351@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 3/11/19 9:18 PM, Paul E. McKenney wrote:
> On Mon, Mar 11, 2019 at 05:28:03PM +0530, Neeraj Upadhyay wrote:
>> Read rhp->func pointer in rcu_head_after_call_rcu() only once,
>> to avoid warning in the case, where call_rcu() happens between
>> two reads of rhp->func.
>>
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> 
> This would more gracefully handle racing rcu_head_after_call_rcu()
> with call_rcu().
> 
> But this thing is not yet used, so let's see what Neil Brown says.
> If he isn't going to use it, my thought is to instead just remove
> this.
> 
> 							Thanx, Paul
> 

Agree, makes sense.

Thanks
Neeraj

>> ---
>>   include/linux/rcupdate.h | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>> index 6cdb1db..174768e 100644
>> --- a/include/linux/rcupdate.h
>> +++ b/include/linux/rcupdate.h
>> @@ -878,9 +878,10 @@ static inline void rcu_head_init(struct rcu_head *rhp)
>>   static inline bool
>>   rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
>>   {
>> -	if (READ_ONCE(rhp->func) == f)
>> +	rcu_callback_t func = READ_ONCE(rhp->func);
>> +	if (func == f)
>>   		return true;
>> -	WARN_ON_ONCE(READ_ONCE(rhp->func) != (rcu_callback_t)~0L);
>> +	WARN_ON_ONCE(func != (rcu_callback_t)~0L);
>>   	return false;
>>   }
>>
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>> member of the Code Aurora Forum, hosted by The Linux Foundation
>>
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
