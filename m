Return-Path: <SRS0=RP3k=52=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953D5C2D0EC
	for <rcu@archiver.kernel.org>; Fri, 10 Apr 2020 23:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EBB206DA
	for <rcu@archiver.kernel.org>; Fri, 10 Apr 2020 23:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq0pktBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDJXyN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 10 Apr 2020 19:54:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43207 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDJXyN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 10 Apr 2020 19:54:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id i10so3997769wrv.10;
        Fri, 10 Apr 2020 16:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uRQKQY5MLocuMcOxHg9Z2GpA34weqMmjIuGmkOK83ig=;
        b=Nq0pktBLwnG3frM5sC99lWqRFeFASPOwc1xIuiQEGTsQfv5A1L1YVo8Y+WiHClmNn8
         PVPY3uDcjEN4Q2Jaal3Jnn4VSZByDQdOkNWzA08nBiLrTsHO+GY2Vu4e0lj9GgdYrAK/
         JC0YrjsO/aYsi65Cm5Wu7lk6Xrm0gnK4W6TVfXQ9s3Fq5z4WHU3sP7NAK3uFPTHLU8Th
         YaqYgr9kWh5HHMEhREorGU7sK/G9zjlb3wsTrxFCM++s/InXY78VfV2b9NTOhu35M2Mx
         /SVbZCXsMqvP2RZg06cNE4AJWarvOXLF+dPrCp3x9xEEGzIpTg4t76J1Ug9icEwvsZL3
         ywtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRQKQY5MLocuMcOxHg9Z2GpA34weqMmjIuGmkOK83ig=;
        b=WR//4dx4fvaOXqq7WgVkvot5TbTrx0Uhji+lOaMkU049OitIRKzL7BAVET02JcydJk
         MWe/eau5t5z7FHViTrtW1Bq8p2HsEg4AHdQouhr9GEst5iMNvGdpQRCV76AYmHFvH8is
         OOvMn9LczxAUevz+hcq6JEmstaYawiWXnJkdWxOoVYGj7Br3wn6uJJWX6CeBsBAP8YnH
         VwC53kxPHDO3eFTYuoo0dmw0933e/ol45wqqwdrinXf5e694Q8ITTYqmF0qACOYfzKTz
         RNP5kBA+sHWsaWY7/NuwR+6Nye+jHmOK0b0LbIJ6EUdiAjw9ss4Vm45L/i/HxBRuNHfs
         9yPQ==
X-Gm-Message-State: AGi0Pub+iDsVgOgpDlWUHLJ5gfgs2SpG3h3PkttxqpRyQp03pM3Xbhb0
        sia2tHE23797sULAs6AM/nE=
X-Google-Smtp-Source: APiQypJqV8NqlDHubRsMiCg1XL7wQ/RrIScPAc3rIpJVWTfJUA2ZHltSkrFIADuk7iEq1pgzJPdt5g==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr6806367wrp.130.1586562851893;
        Fri, 10 Apr 2020 16:54:11 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id f63sm4628279wma.47.2020.04.10.16.54.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Apr 2020 16:54:10 -0700 (PDT)
Date:   Fri, 10 Apr 2020 23:54:09 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/rcu: fix a typo in RTFP
Message-ID: <20200410235409.szc3wyvpqevgtkil@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200409132437.11531-1-richard.weiyang@gmail.com>
 <20200409134634.GL17661@paulmck-ThinkPad-P72>
 <20200409211851.ttld7nmkqmncovhe@master>
 <20200409214034.GQ17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409214034.GQ17661@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 09, 2020 at 02:40:34PM -0700, Paul E. McKenney wrote:
>On Thu, Apr 09, 2020 at 09:18:51PM +0000, Wei Yang wrote:
>> On Thu, Apr 09, 2020 at 06:46:34AM -0700, Paul E. McKenney wrote:
>> >On Thu, Apr 09, 2020 at 01:24:37PM +0000, Wei Yang wrote:
>> >> If I am correct, this character should be 'u'.
>> >> 
>> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >
>> >Nice!!!  ;-)
>> >
>> 
>> Hi, Paul
>> 
>> Glad to hear from you.
>> 
>> >This is a play on words between the word you are thinking of and the
>> >old UNIX "fsck" (filesystem check) utility.  It stays, but rest assured
>> >that you did get point!
>> >
>> 
>> Sorry I am confused.
>> 
>> My change is correct or the word fsck is correct and it means "read filesystem
>> check papers"?
>
>https://en.wikipedia.org/wiki/Fsck#As_an_expletive
>
>Interestingly enough, this section is missing from the Chinese
>translation of this page.  ;-)
>

Oops, I see it. That's interesting. 

>							Thanx, Paul
>
>> >> ---
>> >>  Documentation/RCU/RTFP.txt | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> 
>> >> diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
>> >> index 9bccf16736f7..261eeb501ba5 100644
>> >> --- a/Documentation/RCU/RTFP.txt
>> >> +++ b/Documentation/RCU/RTFP.txt
>> >> @@ -1,4 +1,4 @@
>> >> -Read the Fscking Papers!
>> >> +Read the Fucking Papers!
>> >>  
>> >>  
>> >>  This document describes RCU-related publications, and is followed by
>> >> -- 
>> >> 2.23.0
>> >> 
>> 
>> -- 
>> Wei Yang
>> Help you, Help me

-- 
Wei Yang
Help you, Help me
