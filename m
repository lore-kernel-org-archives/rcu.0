Return-Path: <SRS0=Hkx7=5Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C486C2BA19
	for <rcu@archiver.kernel.org>; Thu,  9 Apr 2020 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE93E20753
	for <rcu@archiver.kernel.org>; Thu,  9 Apr 2020 21:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/8tCi30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgDIVSy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:18:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32856 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgDIVSy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 9 Apr 2020 17:18:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so13733901wrd.0;
        Thu, 09 Apr 2020 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GrPYg+oHygD4pLQkW2MfFtRBkd4olu1YsU5G2+/EDGM=;
        b=R/8tCi30CDpdkrtny0UnfohQ0kreT6pz5502OZwLzFU1GlWt/nB/E7ruZLG4cNGyO+
         F6j8CXQzv1BiPFh8OxApxTNbC36PBJIJZTGWBNjTXFLnG1xrtsDfGzOJIQ5vhIutJQA2
         kLQhQWZeViLr0rvOF3bWqdbHnoIPqr5Z3+UPe5cpRooUBKqkTMrUavRIzuP6tNxz76IL
         WWxkrgkFWLbsIg3o86aqsg4uG3J/3BYKNr+eNipZBKUEUcyFkdTQnvlIkY9aDV+y25Bk
         ugAVcKuQPzmUt+keUQsqf4fQZXNN/tCYzfJWtnrAukRW7eqN9QS2AKHLXG/r7wQf+n6B
         EGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GrPYg+oHygD4pLQkW2MfFtRBkd4olu1YsU5G2+/EDGM=;
        b=mNmn3IU/ZC0CItCiSx5knYNEOCpfzzpujueDn3hfx7ZIvUSBKnxzWsrvDXWE4XR5D3
         W/3WpBj9eadud+rVF6bPhYkvRlcPaMZTPJ1i6Ey/KdoWxtD94mpYQNfElyt02jYPjCiG
         a1hivu5ibnFBjlgRZbFZ3xoFbSUvADjxsHNVBde8SOayBGQQ9OwcslPZe9K3luss9V4G
         EuXOARlZlI4NqfgIJk/ZsSOfceFLyPv/aRsukXGXF+vzpi2yJ0+8Df7Y7NgDgQ6IaTRf
         Isi+Z6lrzwYXmQgd1ImfaHo/IylJSr2GDKoJsj+UAtgm/abUMOhpB6hS3lOkTYkmkGQp
         y+HA==
X-Gm-Message-State: AGi0PuaHnV6zhnDtnjKZLXA2NnV27rgCsmLSTDIAPuk5xy4dIKwb9aZf
        UM+WfFbQiHudz5UhZbjdThI=
X-Google-Smtp-Source: APiQypK1SQsMj0euJTMCWn9ZOEZJKEGqAsIzCKX7PkyTL9bHnOHr19OU3MsZM0Fj9thFZiiPD/LuEA==
X-Received: by 2002:a5d:53ce:: with SMTP id a14mr1059856wrw.129.1586467133140;
        Thu, 09 Apr 2020 14:18:53 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k9sm383381wrd.17.2020.04.09.14.18.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Apr 2020 14:18:52 -0700 (PDT)
Date:   Thu, 9 Apr 2020 21:18:51 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/rcu: fix a typo in RTFP
Message-ID: <20200409211851.ttld7nmkqmncovhe@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200409132437.11531-1-richard.weiyang@gmail.com>
 <20200409134634.GL17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409134634.GL17661@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 09, 2020 at 06:46:34AM -0700, Paul E. McKenney wrote:
>On Thu, Apr 09, 2020 at 01:24:37PM +0000, Wei Yang wrote:
>> If I am correct, this character should be 'u'.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>Nice!!!  ;-)
>

Hi, Paul

Glad to hear from you.

>This is a play on words between the word you are thinking of and the
>old UNIX "fsck" (filesystem check) utility.  It stays, but rest assured
>that you did get point!
>

Sorry I am confused.

My change is correct or the word fsck is correct and it means "read filesystem
check papers"?

>							Thanx, Paul
>
>> ---
>>  Documentation/RCU/RTFP.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
>> index 9bccf16736f7..261eeb501ba5 100644
>> --- a/Documentation/RCU/RTFP.txt
>> +++ b/Documentation/RCU/RTFP.txt
>> @@ -1,4 +1,4 @@
>> -Read the Fscking Papers!
>> +Read the Fucking Papers!
>>  
>>  
>>  This document describes RCU-related publications, and is followed by
>> -- 
>> 2.23.0
>> 

-- 
Wei Yang
Help you, Help me
