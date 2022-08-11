Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDFBC00140
	for <rcu@archiver.kernel.org>; Thu, 11 Aug 2022 02:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiHKCcD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 Aug 2022 22:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiHKCcB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 Aug 2022 22:32:01 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3211F88DDD
        for <rcu@vger.kernel.org>; Wed, 10 Aug 2022 19:32:00 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id d1so12440709qvs.0
        for <rcu@vger.kernel.org>; Wed, 10 Aug 2022 19:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=59BW7/Ip/IlB4q8qRutBL8VhwSHLJCviZn8DE3Eq3+M=;
        b=g6Hrbi1SrgMQgfXV0cFES51r8PcZl3OXbTHxf6RmislSBdOpCuv3kcNzTTj1qmPPmA
         ZXM1Z6gib8ZDe8O9XcZrzXqhvxdfngB9TupfB5R1oVHUXeGScY2ZnPghgAWfFaPeGu6e
         atrhvF5e5/ByNWnbYZtWLOKzdieVRgw+1UWik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=59BW7/Ip/IlB4q8qRutBL8VhwSHLJCviZn8DE3Eq3+M=;
        b=lAu4C4wmhH37EHA5QPbntpdO03rbiyUJYTEWvLw642VcovXwb4UoDKlMMqIDw3aNwB
         /9ck2Fu5kybtCKBy5Ht3Su4b0O0pzc3CouI+c/XI40TY6ZBfK3BCJ67bvKS+ZCtg7pzA
         tgCrnHvMPty8C30Vqv62SdVqdywMqXskXgXvhdlU5Ao7QE5K8JsWrNfhErBTpuur8r9d
         NayAJLnqo9UoW2KjEwdycEONxAzT7jq0t+FgKBJxdRLQtYMOfmW3mEPCvDCrKIFpGVml
         4X2m96t3DLQSDRyyrN0SR2AjWxb7AKKZHoouFKrqKFtnx+4rG7vTkW5tCDeeESwi8Lfy
         4p5Q==
X-Gm-Message-State: ACgBeo2AUpRUfpV9f4UP1m9Is5OKUTvqXNZF0zHnt7Nh8B+kRQRwYbkC
        kepvvh/Xk+Dv9t3JQUloirtKyQ==
X-Google-Smtp-Source: AA6agR5Qjb7gj8xWC6fpxPO5IpeCozRPpLsy6DnI8vYWq60hc05soAvHdRaJRnisycVD9fXU/ImYKA==
X-Received: by 2002:a05:6214:a4f:b0:474:8b63:556f with SMTP id ee15-20020a0562140a4f00b004748b63556fmr26454295qvb.55.1660185119339;
        Wed, 10 Aug 2022 19:31:59 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id t11-20020a05622a01cb00b0033c36ef019esm1038212qtw.63.2022.08.10.19.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 19:31:58 -0700 (PDT)
Message-ID: <87663566-ed67-fee8-4598-13591f2f072b@joelfernandes.org>
Date:   Wed, 10 Aug 2022 22:31:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v3 resend 0/6] Implement call_rcu_lazy() and miscellaneous
 fixes
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
References: <20220809034517.3867176-1-joel@joelfernandes.org>
 <308db02b-b56d-2df1-ee33-7f66e6a85f63@joelfernandes.org>
In-Reply-To: <308db02b-b56d-2df1-ee33-7f66e6a85f63@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 8/10/2022 10:23 PM, Joel Fernandes wrote:
> 
> 
> On 8/8/2022 11:45 PM, Joel Fernandes (Google) wrote:
>> Just a refresh of v3 with one additional debug patch. v3's cover letter is here:
>>  https://lore.kernel.org/all/20220713213237.1596225-1-joel@joelfernandes.org/
>>
>> I just started working on this again while I have some time during paternity
>> leave ;-) So I thought I'll just send it out again. No other changes other
>> than that 1 debug patch I added on the top.
>>
>> Next I am going to go refine the power results as mentioned in Paul's comments
>> on the last cover letter.
> 
> Side note: Here is another big selling point for call_rcu_lazy().
> Instead of _lazy(), if you just increased jiffies_till_first_fqs, and
> slowed *all* call_rcu() down to achieve the same effect, that would
> affect percpu refcounters switching to atomic-mode, for example.
> 
> They switch to atomic mode by calling __percpu_ref_switch_mode() which
> is called by percpu_ref_switch_to_atomic_sync().>
> This will slow this call down for the full lazy duration which will slow
> down suspend in blk_pre_runtime_suspend().

Correction while I am going on the record (got to be careful these
days). It *might* slow down RCU for the full lazy duration, unless of
course a fly-by rescue call_rcu() comes in.

- Joel
