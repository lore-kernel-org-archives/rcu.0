Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448ECC4332F
	for <rcu@archiver.kernel.org>; Thu, 15 Dec 2022 20:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiLOUFC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Dec 2022 15:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiLOUEd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Dec 2022 15:04:33 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F89C30
        for <rcu@vger.kernel.org>; Thu, 15 Dec 2022 12:03:47 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id s25so115566lji.2
        for <rcu@vger.kernel.org>; Thu, 15 Dec 2022 12:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lY/BfT2XK0AeQGmS9Zw04MeEqG0LziE9KtlXrbZpLXY=;
        b=RVtcCB/PTRx/1MvGPEkrfk1tkvUKwY5J4Hfj3tSYHrJUruOGTq78GEsbgSINXn+eM1
         viw2feS1BWK/wkO6cRcaOW1FhILndT44zEn5psrLG5VRlAYYbsx0EnDgHPHODlJQoZcS
         m7B8Ha0zAvXpJSG54wQDhixNy7M3+p+zT3L3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lY/BfT2XK0AeQGmS9Zw04MeEqG0LziE9KtlXrbZpLXY=;
        b=oP+ZpDLi7paR0G7WpnK1uyZwSW3ew4D54bgaHqLmOKiGlIzdRS6Ha2sl9b1X+hC4+T
         py0FqK/W+kbQT8DBHWglqyRo8rlshPrLR3GxuEtTjrp6h7QGvxD8XBeni40Aon8SCiRP
         4ASP9XAxRcd0OnSMrqh4y9Bgn23puQ/AZb6fX6IoQk8q8Bbj8an/HvXAkv0uVpGNbINH
         rwiGArjUum29c8gpliWgtf9dwG4dpppzY0mIhxSq7OHCL7DiLosFYcHmi3ErNiZa9Zv+
         BcGMqPj2LCzy6zjcDQ10OmTM26lXLub1uL3/bXF9uiMchV6/346G5+wiowoo06eDVUux
         kTgA==
X-Gm-Message-State: ANoB5pmyRgPG6d7xPoANBlVIAOAUpKOeW8BoaBCd5+RMLhgGWCr/nQrP
        kjSjlc7GitIG+1ADz4UFiwwpfyGRP7+S4GhYiCHOKRa/faBZ8A==
X-Google-Smtp-Source: AA0mqf73MUOxTV7lhbeAxqVSOs1BBDngxFeHDdheKL26HOjaRXjnyyL7C45+L5PuHkqzZxnJC3u9kMgzlkV+C4MBmzs=
X-Received: by 2002:a05:651c:124c:b0:279:f45e:ccd6 with SMTP id
 h12-20020a05651c124c00b00279f45eccd6mr7841671ljh.483.1671134625941; Thu, 15
 Dec 2022 12:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <20221215165452.GA1957735@lothringen> <20221215170834.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTSW9kr3DsJm6hTQ0FfwVbVjzDa8=7H29+ysD10ZCbnHA@mail.gmail.com> <20221215195854.GL4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221215195854.GL4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 15 Dec 2022 15:03:34 -0500
Message-ID: <CAEXW_YSnwXA6Bn3Av3O0Tm=AnqKULGZJBA3Z7ZaLE814XABU6g@mail.gmail.com>
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check()
 comments
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Thu, Dec 15, 2022 at 2:58 PM Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > If the first read section's srcu_read_unlock() and its corresponding
> > smp_mb()  happened before the flip, then the increment of old idx
> > would happen only once. The next srcu_read_lock() will read the new
> > index. If the srcu_read_unlock() and it's corresponding smp_mb()
> > happened after the flip, the old_idx will be sampled again and can be
> > incremented twice. So it depends on how the flip races with
> > srcu_read_unlock().
>
> I do understand that a number of people like reasoning about
> memory-barrier ordering, courtesy of the sequentially consistent portions
> of the C and C++ memory models, but thinking in terms of the accesses
> surrounding the memory barriers has been far less error-prone.

Sure, but we are already talking in terms of the access to idx right?
That's what we're saying is visible by memory barriers and we are
trying to reason here about the ordering (flip does the write to idx
and followed by smp_mb(), and there is corresponding read of idx on
the srcu_read_lock() side. So we are indeed talking in terms of
access, but let me know if I missed something.

> > Also, since this is all hard to reason about I started making some
> > diagrams, LOL. For your amusement, here is why need to scan both idx
> > during grace period detection: https://i.imgur.com/jz4bNKd.png
>
> Nice!
>
> I suggest placing a gap between GP 2 and GP 3.  That way, you can make it
> very clear that Reader 1's critical section starts after the end of GP 2
> (thus clearly never blocking GP 2) and before GP 3 (thus possibly having
> a reference to some data that is going to be freed at the end of GP 3).
>
> I also suggest coloring Reader 1 red and Reader 2 green, given that the
> color red generally indicates danger.

Thanks for these suggestions! I will make the update. I am planning to
make a number of diagrams for other scenarios as well, as it helps
visualize. Google drawing is nice for these. I am happy to share these
with you all if there is interest :).

Thanks!

 - Joel
