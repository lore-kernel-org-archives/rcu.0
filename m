Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96125C001B0
	for <rcu@archiver.kernel.org>; Sun, 23 Jul 2023 14:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjGWOua (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 23 Jul 2023 10:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWOua (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 23 Jul 2023 10:50:30 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403E3A6
        for <rcu@vger.kernel.org>; Sun, 23 Jul 2023 07:50:29 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-635eb5b0320so26972776d6.3
        for <rcu@vger.kernel.org>; Sun, 23 Jul 2023 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690123828; x=1690728628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XbJYLMBE6yZWZtHXhUUqaRNiGofik3CcRLGI3pFqykE=;
        b=YkO18S8ZdFq2T6J3xUhBXqe+9SNwwSJ7cixs31sAhRpASF13+CPFZHEg9o4u3AcqmB
         OPYq3xPQttUC3SQG9ok2raOKj8pJyeZViQtwciZWZmuXPnEOIfTO8ZzgxqGcPGyFHime
         4LLa1KOAt2Q/S+9VTxORf1n5OE8eFSWas9CGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690123828; x=1690728628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbJYLMBE6yZWZtHXhUUqaRNiGofik3CcRLGI3pFqykE=;
        b=lkaKsRyRVz+ERFkYrp11YFb3cwlqJ7+sThCPX7Mti65XRk9NfM5sGu2l0UTYkJe5yl
         cfTtlvtUy4vnv7K3v45rXMkQQW1PzxL2Z56AL++9ooC2+lp8PKXP/AkM0JdNInXUMIrW
         l4fPyEFckon/a6vvTNprda4dxUBY2oQ6NDbYdgu3EaujFFVwILpDu8NGARYSn9egkwZC
         fcru0fRdpQ5xW7P/03t+kf7ACPp1U8bibBQbgSh/9Cm0Thir2RZwqDLWCixVvEWzSCUc
         h0+bj7Q6+G+uqJBXpqqvdwSFOXbfyt8TupDX1D1Yd28AWBbJyGxL1skA0PLsVG6ZYwmH
         SY6w==
X-Gm-Message-State: ABy/qLYsfHU5DJ5VYT/Xn45OBPzPeP17dyyiG4+NeLIr4Tpi98rwfDlQ
        q5Skeak3hCkh5/zimHwarrwRrA==
X-Google-Smtp-Source: APBJJlGtEhT2RjFcanL8kjdpwZNzyNf9eCcws/91q63UCpS2CEvwDCdEc5+8vWTKgA3nRM5sKEqpAw==
X-Received: by 2002:a0c:b551:0:b0:63c:f999:ba83 with SMTP id w17-20020a0cb551000000b0063cf999ba83mr1757454qvd.32.1690123828250;
        Sun, 23 Jul 2023 07:50:28 -0700 (PDT)
Received: from [192.168.0.198] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id s15-20020a0ce30f000000b00637abbfaac9sm97573qvl.98.2023.07.23.07.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 07:50:27 -0700 (PDT)
Message-ID: <a7bcbcf2-9b34-4326-822f-e1f2aa5c5668@joelfernandes.org>
Date:   Sun, 23 Jul 2023 10:50:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [BUG] Re: Linux 6.4.4
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        rcu@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20230720132714.GA3726096@google.com>
 <2b8fc10b-785e-48b9-9a38-5c1af81f9578@paulmck-laptop>
 <CAEXW_YQO7OCdkXm_SBcPhAm8V8vMaF_5DQq7PbG9PZb7RFgA_g@mail.gmail.com>
 <f18e165c-9196-4b41-a202-82cfd5ac7f8b@paulmck-laptop>
 <8682b08c-347b-5547-60e0-013dcf1f8c93@joelfernandes.org>
 <eb04b7d0-2f49-4e01-be09-9062d9f08404@paulmck-laptop>
 <32aec6d1-bf25-7b47-8f31-7b6318d5238d@joelfernandes.org>
 <9b42cb38-8375-fc41-475a-2bd26c60a7b9@joelfernandes.org>
 <5dcf7117-cec7-4772-8aad-e100484a84dc@paulmck-laptop>
 <7bfde9f4-2bd6-7337-b9ca-94a9253d847f@joelfernandes.org>
 <ad82995c-061e-4f97-a972-c13a85ad0b72@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ad82995c-061e-4f97-a972-c13a85ad0b72@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 7/22/23 13:27, Paul E. McKenney wrote:
[..]
> 
> OK, if this kernel is non-preemptible, you are not running TREE03,
> correct?
> 
>> Next plan of action is to get sched_waking stack traces since I have a
>> very reliable repro of this now.
> 
> Too much fun!  ;-)

For TREE07 issue, it is actually the schedule_timeout_interruptible(1)
in stutter_wait() that is beating up the CPU0 for 4 seconds.

This is very similar to the issue I fixed in New year in d52d3a2bf408
("torture: Fix hang during kthread shutdown phase")

Adding a cond_resched() there also did not help.

I think the issue is the stutter thread fails to move spt forward
because it does not get CPU time. But spt == 1 should be very brief
AFAIU. I was wondering if we could set that to RT.

But also maybe the following will cure it like it did for the shutdown
issue, giving the stutter thread just enough CPU time to move spt forward.

Now I am trying the following and will let it run while I go do other
family related things. ;)

+++ b/kernel/torture.c
@@ -733,6 +733,6 @@ bool stutter_wait(const char *title)
                        ret = true;
                }
                if (spt == 1) {
-                       schedule_timeout_interruptible(1);
+                       schedule_timeout_interruptible(HZ / 20);
                        cond_resched();
                } else if (spt == 2) {

