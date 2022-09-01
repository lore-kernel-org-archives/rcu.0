Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C5FECAAD3
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 16:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiIAQIQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiIAQIF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 12:08:05 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E37990C49
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 09:08:01 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b9so13615639qka.2
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 09:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fbLPgUKDeEmpi5XNyJeAxZHlZZP3Z6lE/BSo3Y5wwyI=;
        b=lWVe/bC+Si53mXtJ+1IDEDdGyGm3oRk86702du2JvUscb7XiaS7mWPQMaTMn7Pfc7s
         LIlnolzJYkptY9UJvY2auBeUQINWeq9mnqFDF5MlGRhF/DTTZv8Cp2Eaw+VrCjpQrXYX
         1bS9uaKIXTDMSzc5zYhoSKTMJIOQeC9jm863Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fbLPgUKDeEmpi5XNyJeAxZHlZZP3Z6lE/BSo3Y5wwyI=;
        b=W7GxpKq5TzAgswtv6qIbJgaP4ePWNh/F6FqxpIN2Cf4G7a8Ccz9pE39X6c6N0GeM9B
         pmHH/7Lz5CM2eqPF2b5pR1vg/pWYkz096l1JOEcx1RAfjl4qxx9ixd59nXaKtGzytfn8
         S3cLUZWPLJqb9/3j8kuOWiY5AyZjkyHkrnGnveobXo94PvjRxJW1BsHUlffUlVjDxiKb
         m0jN3t35CBDmqnaMSvft5gM2MUw+fqyilKmIEZzYDRWNQspmiwZFHWB72Ra4ARU6TSmE
         iy2h+LzIUt5AzvRnv0QxMHVyhkGbepWIbo3uBiRGkubuRSqLYkptIIX5NNkQAu5iJjBR
         q6fg==
X-Gm-Message-State: ACgBeo1d4KZt4Qyu3KMhZT0TiPx7QJl12q0xiORtLViICpC3i+QaxeUH
        vGCV0TqLffr5D+CNftRMK6KWsQ==
X-Google-Smtp-Source: AA6agR5OPsi7Ca+K/UzjkYkdBBG/PAq+Osq2CCbPnnpQEyFSe99xEPcD+vKp81LxZCGQqL6K43h9OQ==
X-Received: by 2002:a37:b702:0:b0:6b8:d9ec:3196 with SMTP id h2-20020a37b702000000b006b8d9ec3196mr19729545qkf.660.1662048480173;
        Thu, 01 Sep 2022 09:08:00 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id n3-20020a05620a294300b006b97151d2b3sm12547778qkp.67.2022.09.01.09.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:07:59 -0700 (PDT)
Message-ID: <0e8687de-bf45-5de6-c2f1-be6084991921@joelfernandes.org>
Date:   Thu, 1 Sep 2022 12:07:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
References: <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen> <20220830162244.GA73392@lothringen>
 <20220830164634.GC6159@paulmck-ThinkPad-P17-Gen-1>
 <20220831152658.GA89704@lothringen>
 <20220901143907.GU6159@paulmck-ThinkPad-P17-Gen-1>
 <20220901145819.GB105556@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220901145819.GB105556@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 9/1/2022 10:58 AM, Frederic Weisbecker wrote:
> On Thu, Sep 01, 2022 at 07:39:07AM -0700, Paul E. McKenney wrote:
>> On Wed, Aug 31, 2022 at 05:26:58PM +0200, Frederic Weisbecker wrote:
>>> On Tue, Aug 30, 2022 at 09:46:34AM -0700, Paul E. McKenney wrote:
>>>>> Although who knows, may be some periodic file operation while idle are specific
>>>>> to Android. I'll try to trace lazy callbacks while idle and the number of grace
>>>>> periods associated.
>>>>
>>>> Sounds like a good start.
>>>>
>>>> And yes, we don't need to show that the whole !NOCB world needs this,
>>>> just some significant portion of it.  But we do need some decent evidence.
>>>> After all, it is all too easy to do a whole lot of work and find that
>>>> the expected benefits fail to materialize.
>>>
>>> So here is some quick test. I made a patch that replaces Joel's 1st patch
>>> with an implementation of call_rcu_lazy() that queues lazy callbacks
>>> through the regular call_rcu() way but it counts them in a lazy_count.
>>>
>>> Upon idle entry it reports whether the tick is retained solely by lazy
>>> callbacks or not.
>>>
>>> I get periodic and frequent results on my idle test box, something must be
>>> opening/closing some file periodically perhaps.
>>>
>>> Anyway the thing can be tested with this branch:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
>>> 	rcu/lazy-trace
>>>
>>> Excerpt:
>>>
>>>           <idle>-0       [007] d..1.   414.226966: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>>>           <idle>-0       [007] d..1.   414.228271: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>>>           <idle>-0       [007] d..1.   414.232269: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>>>           <idle>-0       [007] d..1.   414.236269: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>>
>> Just to make sure that I understand, at this point, there is only the
>> one lazy callback (and no non-lazy callbacks) on this CPU, and that
>> CPU is therefore keeping the tick on only for the benefit of that one
>> lazy callback.  And for the above four traces, this is likely the same
>> lazy callback.
>>
>> Did I get it right, or is there something else going on?
> 
> Exactly that!

Interesting!

 - Joel

