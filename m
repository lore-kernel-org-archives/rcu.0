Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45695ECAAD4
	for <rcu@archiver.kernel.org>; Mon, 29 Aug 2022 20:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiH2Usk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiH2Usj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 29 Aug 2022 16:48:39 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DBF9AFBA
        for <rcu@vger.kernel.org>; Mon, 29 Aug 2022 13:48:39 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b142so7611071iof.10
        for <rcu@vger.kernel.org>; Mon, 29 Aug 2022 13:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cHgb8is1s1/IIdUooiK63RBMdZzZXw58VVRpVaSHSIU=;
        b=wCqx693sslE2Savk58+n/qDHWX1TwwcS2+j3NFpcEfuSG+6DcMH5q7RP39tS1bx/VG
         9RI6VRuHaPfJZQuMCEj89hKiCgBkDEg4woLdZgEOqNloT9Yzn4SmYjKCmtAk9Ed2q/7N
         CPmTfynuiBHSaDEL6BtHEUjSYcTX1GcB5vuFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cHgb8is1s1/IIdUooiK63RBMdZzZXw58VVRpVaSHSIU=;
        b=kxPB0/15VRXmkZ6Wh/KzB/mG3/qphXO9RaXNtcZ/zrAop/ofHDhsawswE3xI/sUq6M
         YLjkO+BljOw6xE5t3wvnKoudFeaJvfDbtSodWZ3OXPZ29PTzvCUX1c/zpCvQs4RA0WdL
         jiOcw3i2uGgjMASjtgmYsz5FLfydiPSXH+IpWe8TgqvHiIWIJ4/ycoFcwFdbXFDBxN/l
         PYIh/ndcE3dEY1xeKsJ5sLZ0gS4FCikyP7TQXglZoezxvsdH284LLODzc9onUyrlyg87
         2YLqJZXpVCj9g40k6zUzPRHMgd3rxkQGS0W1iuCzMLZuj/W1z7kDSGJ1i4Jo3kifIlBx
         N3FQ==
X-Gm-Message-State: ACgBeo0MctDMLamL2qUe+/OmlUcwb53dBa3Y7c3CysRTtBcKtYR/4X22
        uXnsssJh1JDViet5KAdMCSsk+niZ1UEu9gPcYeCQBw==
X-Google-Smtp-Source: AA6agR7O/puL5L5YaRhK8BLONsdd+lAAqiJ1hNdUqhBbc6rhB+OrPdzdM7Tug6JV0zkZFDFG34gQBz5APaMWZkAJ9Ek=
X-Received: by 2002:a05:6638:160b:b0:346:ab00:9c7c with SMTP id
 x11-20020a056638160b00b00346ab009c7cmr10657775jas.241.1661806118443; Mon, 29
 Aug 2022 13:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen> <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen> <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 29 Aug 2022 16:48:25 -0400
Message-ID: <CAEXW_YSwkSi0UfBUrK=4gyMPC-R7pvQbreWOC3DcQqmLgp3aFQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous fixes
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 29, 2022 at 4:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Aug 29, 2022 at 04:36:40PM -0400, Joel Fernandes wrote:
> > On Mon, Aug 29, 2022 at 3:46 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > On Mon, Aug 29, 2022 at 12:45:40PM -0400, Joel Fernandes wrote:
> > > > On 8/29/2022 9:40 AM, Frederic Weisbecker wrote:
>
> [ . .  . ]
>
> > > > > 2) NOCB implies performance issues.
> > > >
> > > > Which kinds of? There is slightly worse boot times, but I'm guessing that's do
> > > > with the extra scheduling overhead of the extra threads which is usually not a
> > > > problem except that RCU is used in the critical path of boot up (on ChromeOS).
> > >
> > > I never measured it myself but executing callbacks on another CPUs, with
> > > context switches and locking can only involve significant performance issues if callbacks
> > > are frequent. So it's a tradeoff between power and performance.
> >
> > In my testing of benchmarks on real systems with 8-16 CPUs, the
> > performance hit is down in the noise. It is possible though that maybe
> > one can write a non-realistic synthetic test to force the performance
> > issues, but I've not seen it in the real world. Maybe on
> > networking-heavy servers with lots of cores, you'll see it but their
> > batteries if any would be pretty big :-).
>
> To Frederic's point, if you have enough servers, even a 1% decrease in
> power consumption is a very big deal.  ;-)

Ah I see Frederick's point now, so basically the claim is that using
lazy-RCU on servers might make sense to save power because
CONFIG_RCU_NO_CB_CPU may not be an option there (networking throughput
and so forth).

That's a good point indeed...

As you said, let us see v5 and how we want to proceed from there (as
it is not too far from posting) . I do appreciate Frederick's review
and valid concerns.

Thanks,

- Joel
