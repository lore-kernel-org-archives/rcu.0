Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF903C433EF
	for <rcu@archiver.kernel.org>; Tue, 12 Jul 2022 21:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiGLVPd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Jul 2022 17:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGLVPc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Jul 2022 17:15:32 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED9BAF76B
        for <rcu@vger.kernel.org>; Tue, 12 Jul 2022 14:15:31 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f12so7242171qka.12
        for <rcu@vger.kernel.org>; Tue, 12 Jul 2022 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HDxIKR5RZX5hxcnOWzngwENoyujLpmp2i20B6Du0SD0=;
        b=t1jqDN4diP7PGhDFRbIYdTcZo3TnW78eug9gswc22ayAkchjHWaBjv7ra/b6tNZrfC
         FXr8XWDh4knjVpA7+Ofy8h4EMhrfxxeM8Jva9Y4eoOtcpqWIBSbOdWG0fOK/Npkp/422
         /BihrPbs/1eHoklLQfvlP8VupGeO0flemzUrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HDxIKR5RZX5hxcnOWzngwENoyujLpmp2i20B6Du0SD0=;
        b=6MzcWw5r5SfDEXtNOZTHbQ+CCbRPYZbto/2SNYsG1Ws06gKjWQFJ2jTdrPqnqp9gfL
         +lfuY2UY+c0sqr+1T0H9p8BLikpyOWXcND78IIS6yHs5zaG5ZqR5FEVNVqwOho4huyPt
         MugprnGoxGHWC9q8+4MPSR3dTJlOq+fJmrhC2AW1V5e7v0G38npIjFf6QugVRlyD+Et/
         TrZpBELyHE7zl2XoihLG32dJxHOmqGYbTdbbql88RTufNz6Ot4ebJWYUsW67uETSbd/K
         81xo1WO0GyIqyIrYmnrA6WFNZLEemlxD/WLsWwsx2mrOvIrVCxMj0Egf7DnOBkKbbBvT
         ViVg==
X-Gm-Message-State: AJIora93Fr5eK+FW74rXLHMMmsQfmWuYeo9P5gF5NZ+LuVkzJcYkAg8z
        i6hX9d01ied+xS5OC1v4XJAXyw==
X-Google-Smtp-Source: AGRyM1veRnvk+PMBF9VaOViVhnFCfznll5eRtTZb1k2KsThodEujAJthvoM63kmR3wVl4HdwFRm9Lg==
X-Received: by 2002:a05:620a:1008:b0:6b5:70c8:e2a1 with SMTP id z8-20020a05620a100800b006b570c8e2a1mr193131qkj.342.1657660530231;
        Tue, 12 Jul 2022 14:15:30 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id d9-20020ac85ac9000000b0031eb3af3ffesm274737qtd.52.2022.07.12.14.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 14:15:29 -0700 (PDT)
Message-ID: <dc5b3c63-7c95-79aa-75ec-1e8d1b3315f1@joelfernandes.org>
Date:   Tue, 12 Jul 2022 17:15:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH v2 6/8] rcuscale: Add test for using call_rcu_lazy() to
 emulate kfree_rcu()
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vineeth@bitbyteword.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-8-joel@joelfernandes.org>
 <20220626041327.GN1790663@paulmck-ThinkPad-P17-Gen-1>
 <YsexpcG2iaplKPIs@google.com>
 <20220708230600.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YS8hrT78JG_2uQX38oaF5TEGz-M3EgJ2PWjx8g+cfmhBw@mail.gmail.com>
 <20220712205854.GE1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220712205854.GE1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 7/12/2022 4:58 PM, Paul E. McKenney wrote:
> On Tue, Jul 12, 2022 at 04:27:05PM -0400, Joel Fernandes wrote:
>> Ah, with all the threads, I missed this one :(. Sorry about that.
> 
> I know that feeling...
> 
>> On Fri, Jul 8, 2022 at 7:06 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>>
>>>> Currently I added a test like the following which adds a new torture type, my
>>>> thought was to stress the new code to make sure nothing crashed or hung the
>>>> kernel. That is working well except I don't exactly understand the total-gps
>>>> print showing 0, which the other print shows 1188 GPs. I'll go dig into that
>>>> tomorrow.. thanks!
>>>>
>>>> The print shows
>>>> TREE11 ------- 1474 GPs (12.2833/s) [rcu_lazy: g0 f0x0 total-gps=0]
>>>> TREE11 no success message, 7 successful version messages
>>>
>>> Nice!!!  It is very good to see you correctly using the rcu_torture_ops
>>> facility correctly!
>>>
>>> And this could be good for your own testing, and I am happy to pull it
>>> in for that purpose (given it being fixed, having a good commit log,
>>> and so on).  After all, TREE10 is quite similar -- not part of CFLIST,
>>> but useful for certain types of focused testing.
>>>
>>> However, it would be very good to get call_rcu_lazy() testing going
>>> more generally, and in particular in TREE01 where offloading changes
>>> dynamically.  A good way to do this is to add a .call_lazy() component
>>> to the rcu_torture_ops structure, and check for it in a manner similar
>>> to that done for the .deferred_free() component.  Including adding a
>>> gp_normal_lazy module parameter.  This would allow habitual testing
>>> on a few scenarios and focused lazy testing on all of them via the
>>> --bootargs parameter.
>>
>> Ok, if you don't mind I will make this particular enhancement to the
>> torture test in a future patchset, since I kind of decided on doing v3
>> with just fixes to what I have and more testing. Certainly happy to
>> enhance these tests in a future version.
> 
> No need to gate v3 on those tests.
> 
>>> On the total-gps=0, the usual suspicion would be that the lazy callbacks
>>> never got invoked.  It looks like you were doing about a two-minute run,
>>> so maybe a longer run?  Though weren't they supposed to kick in at 15
>>> seconds or so?  Or did this value of zero come about because this run
>>> used exactly 300 grace periods?
>>
>> It was zero because it required the RCU_FLAVOR torture type, where as
>> my torture type was lazy. Adding RCU_LAZY_FLAVOR to the list fixed it
>> :)
> 
> Heh!  Then it didn't actually do any testing.  Done that as well!

Sorry to not be clear, I meant the switch-case list below, not the
torture list in rcutorture.c! It was in the rcutorture.c so was being
tested, just reporting zero gp_seq as I pointed.

/*
 * Send along grace-period-related data for rcutorture diagnostics.
 */
void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
                            unsigned long *gp_seq)
{
        switch (test_type) {
        case RCU_FLAVOR:
        case RCU_LAZY_FLAVOR:
                *flags = READ_ONCE(rcu_state.gp_flags);
                *gp_seq = rcu_seq_current(&rcu_state.gp_seq);
                break;
        default:
                break;
        }
}
EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
