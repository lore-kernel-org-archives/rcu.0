Return-Path: <SRS0=YNYv=U2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D883CC48BD9
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 16:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADE22054F
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 16:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561654107;
	bh=UblD88ZP8YsO31Z318Atdz+Thzt07rySNXirdqTxS7g=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=cEaH8dCB0LRV+vOLW4RWdP+94JczaBtQMaU0C9j8ovB0lEd/Z05eZIcniO25M7Vjt
	 spP8dF5iSegHgYPW6LQUJcqPKS9E35eU84KS8jjlZAhwIEvjAKr067/vWW20ejivef
	 fhxU96d3j6bhiasRm+Oc9yMLe3FzZNbujEmK9ZBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfF0Qs1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:48:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46108 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfF0Qs1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 27 Jun 2019 12:48:27 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so6160344iol.13
        for <rcu@vger.kernel.org>; Thu, 27 Jun 2019 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FSxEQEwWXUDItNoK7vY0AlbovOjmluDRF+4HCcUcjTM=;
        b=fA0ca0ckexfe+375seGTFN8cd84uWva+6RdFl/AkmQYIihmm8vjxWWbj6rBQCgQRwD
         DjR9pIMXgPWpG68ir6UBjicQkg8d7oTnyx3LVirlRaDZgapXZNydLZDnCETW+bu1cCrs
         gk+AwiJj/Sx+yIv7pmsTesPz10DV1oWu2assY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FSxEQEwWXUDItNoK7vY0AlbovOjmluDRF+4HCcUcjTM=;
        b=ZKWLLqbVxydVChlUOPkT3EYPT1xCFVmzb2G3SXiyT4SjcrpRuQsy8hnMMH5KgeXhoQ
         9qzvamb5GZ+eC5dtKvbAnQMe4zWPy9QupYtTYYYIrA+0AnSr8WoAMxAWNAhwNzqokB5R
         oU3ta77LdQnq6lrwqvZPwX6F30RLo9zcsZx/rvC2EE20LjFpdK0y11JhO8krUzxjMCoQ
         TWlaYf64CFm2ICauuDW2rrPF/oCPTg90YSGCnTd1G4hyMkpW43VLjmlqJ6rGQmcGfflq
         hj22wZtKPvahvPSsMVWAtCMNycSA3fY1ST60c/L6DgSXisrfyetLz72u9I2kFd33y+Kv
         JIEg==
X-Gm-Message-State: APjAAAVSVZwn499xxiLq3WeERkFwi4Ix1TLXvd17wPlzqRU4+kBOoN8e
        5AWP1xtweDa7/or6wbmxSt81UA==
X-Google-Smtp-Source: APXvYqzlOYEOG860XZk8yS7NdvJ5w74zHEwO4hSyDTzIQxgV2ZhSLo4vBcRx2qRAS1rEu2ND476QEw==
X-Received: by 2002:a02:a07:: with SMTP id 7mr5876624jaw.65.1561654106422;
        Thu, 27 Jun 2019 09:48:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c2sm1852242iok.53.2019.06.27.09.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 09:48:25 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees][PATCH v5 1/5] Documentation: RCU: Convert
 RCU basic concepts to reST
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Jiunn Chang <c0d1n61at3@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20190626191249.21135-1-c0d1n61at3@gmail.com>
 <20190626200705.24501-2-c0d1n61at3@gmail.com>
 <20190627083443.4f4918a7@lwn.net>
 <20190627111324.1db0f1ec@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <83bb7141-d291-de27-f833-6fa485b406b6@linuxfoundation.org>
Date:   Thu, 27 Jun 2019 10:48:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627111324.1db0f1ec@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 6/27/19 9:13 AM, Steven Rostedt wrote:
> On Thu, 27 Jun 2019 08:34:43 -0600
> Jonathan Corbet <corbet@lwn.net> wrote:
> 
>> On Wed, 26 Jun 2019 15:07:01 -0500
>> Jiunn Chang <c0d1n61at3@gmail.com> wrote:
>>
>>> RCU basic concepts reST markup.
>>>
>>> Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
>>> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>
>> So this is a little detail but ... your signoff should be the last thing
>> in the set of tags on the patch.
> 
> Note, I've been seeing this a lot lately, and then noticed, that when I
> downloaded a patch directly from patchwork, it placed all the
> Reviewed-by and Acked-by tags after the original Signed-off-by. I
> checked the original patch on the mailing list, and it had no other
> tags but the Signed-off-by. I then pulled one of my own patches, and it
> did it to that patch as well.
> 
> I too prefer the Signed-off-by be last, but our tooling needs to do
> this as well, otherwise it's a failure in our procedures.
> 

Thanks Steve for pointing this out. I am seeing some odd behavior with tags.

It appears some maintainers want the tags in chronological order, which
is Reviewed-by after Signed-off which doesn't make sense to me.

I prefer Signed-off-by last.

I am working on FAQ (Frequently Answered Questions) section for mentees.
I will add this to it.

thanks,
-- Shuah


