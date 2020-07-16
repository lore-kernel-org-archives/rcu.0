Return-Path: <SRS0=oPal=A3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C06C433DF
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 14:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E65C20825
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 14:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEjIqLiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgGPOpL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgGPOpI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jul 2020 10:45:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA6DC08C5CE
        for <rcu@vger.kernel.org>; Thu, 16 Jul 2020 07:45:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q4so7503562lji.2
        for <rcu@vger.kernel.org>; Thu, 16 Jul 2020 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEqbgXg5bolFCkaEREfRLUaB6wjIdNl0kMgYuxyNxpI=;
        b=GEjIqLiPxGWf30Xto3dr/VRzc+jve2MqdPGTM9sUQj6SX8bHj0uzqXyVE5K8msut3n
         LcgTNQNJqtw7IemIFS+OMy8vmAQJCY2yQD7IgTshitTlPFcWnVmsuYJ0Z2hDwfzIKbUJ
         cKheZtsoJichKATZ899iNX3ePelWfAebfy3ARo5wiIs/R4Ud+5wEUK8+rmEAaUYXT4EQ
         dVl7m668gegN7uHOzqeusAgXDr24DBP48h/z5g7LjaM5rNfYR1pD6vD7nw/+P7k2Db7a
         4tu57r9py1rEFDd2fujZs9B4aNhKOTlR4jVM85AT7LS+H2TzMmskAYFNea1MPtilOpHP
         uxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEqbgXg5bolFCkaEREfRLUaB6wjIdNl0kMgYuxyNxpI=;
        b=hs8lTAW6EAWLCcCKiqllo2xfl/U/iBgKcKzkNR8B4JGqe5vSfI/5CZ0XxEJGSAytgO
         uV99MqmLn0nmO3KucO//pLhfJfpvIILgomN3NrLVN/Atqe7AwLW4gqT0ONQFouHwbd8M
         mp3fVci5cX/dXitThUmBwR9AP4Ni5lxv6VKUcS4crix3BqAtH7/RWbW8C/OVDlMk6eZa
         9tdHXCrsOfEEbh4LgZOhDIrE1+8E7qeiLY6gOvO0UaoomCYB1c/fyefRGOg2xQT0i9Rv
         sUHtQFi+KOpLBF8K7j0gIsRmpBxRc5sd++fQxvmPQ8g56Ujs3zCZlz8mgi3lAxBPiotF
         xHPw==
X-Gm-Message-State: AOAM532t5Xqzh6l7OoSs+tdNqyEZQYxfq2x15u2/+ubhy3TFstxC9qDT
        UB2qkt6v+3SSJM1cpEYyaigM+GF00mWVjzgKh+0zgA==
X-Google-Smtp-Source: ABdhPJwJEhKsmRxsAvPniebMSKL4vf5R0zcd380KCBeBrDwpEZAgDNUsbbYigJ6CStV4ZzKU0+7UrLBBBKm2jdUPO50=
X-Received: by 2002:a2e:b054:: with SMTP id d20mr2073091ljl.55.1594910706505;
 Thu, 16 Jul 2020 07:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200712131003.23271-1-madhuparnabhowmik10@gmail.com>
 <20200712131003.23271-2-madhuparnabhowmik10@gmail.com> <20200712160856.GW9247@paulmck-ThinkPad-P72>
In-Reply-To: <20200712160856.GW9247@paulmck-ThinkPad-P72>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Jul 2020 20:14:54 +0530
Message-ID: <CA+G9fYuVmTcttBpVtegwPbKxufupPOtk_WqEtOdS+HDQi7WS9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] kvm: mmu: page_track: Fix RCU list API usage
To:     madhuparnabhowmik10@gmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     josh@joshtriplett.org, Joel Fernandes <joel@joelfernandes.org>,
        Paolo Bonzini <pbonzini@redhat.com>, rcu@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        frextrite@gmail.com, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, 12 Jul 2020 at 21:39, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Jul 12, 2020 at 06:40:03PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >
> > Use hlist_for_each_entry_srcu() instead of hlist_for_each_entry_rcu()
> > as it also checkes if the right lock is held.
> > Using hlist_for_each_entry_rcu() with a condition argument will not
> > report the cases where a SRCU protected list is traversed using
> > rcu_read_lock(). Hence, use hlist_for_each_entry_srcu().
> >
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
> I queued both for testing and review, thank you!
>
> In particular, this one needs an ack by the maintainer.
>
>                                                         Thanx, Paul
>
> >  arch/x86/kvm/mmu/page_track.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
> > index a7bcde34d1f2..a9cd17625950 100644
> > --- a/arch/x86/kvm/mmu/page_track.c
> > +++ b/arch/x86/kvm/mmu/page_track.c
> > @@ -229,7 +229,8 @@ void kvm_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
> >               return;
> >
> >       idx = srcu_read_lock(&head->track_srcu);
> > -     hlist_for_each_entry_rcu(n, &head->track_notifier_list, node)
> > +     hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
> > +                             srcu_read_lock_held(&head->track_srcu))

x86 build failed on linux -next 20200716.

arch/x86/kvm/mmu/page_track.c: In function 'kvm_page_track_write':
include/linux/rculist.h:727:30: error: left-hand operand of comma
expression has no effect [-Werror=unused-value]
  for (__list_check_srcu(cond),     \
                              ^
arch/x86/kvm/mmu/page_track.c:232:2: note: in expansion of macro
'hlist_for_each_entry_srcu'
  hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
  ^~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/kvm/mmu/page_track.c: In function 'kvm_page_track_flush_slot':
include/linux/rculist.h:727:30: error: left-hand operand of comma
expression has no effect [-Werror=unused-value]
  for (__list_check_srcu(cond),     \
                              ^
arch/x86/kvm/mmu/page_track.c:258:2: note: in expansion of macro
'hlist_for_each_entry_srcu'
  hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
  ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [arch/x86/kvm/mmu/page_track.o] Error 1

build link,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/815/consoleText

-- 
Linaro LKFT
https://lkft.linaro.org
