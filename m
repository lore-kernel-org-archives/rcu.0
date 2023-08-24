Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F83C6FA8F
	for <rcu@archiver.kernel.org>; Thu, 24 Aug 2023 23:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbjHXXHh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Aug 2023 19:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244012AbjHXXHe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Aug 2023 19:07:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650631BDB
        for <rcu@vger.kernel.org>; Thu, 24 Aug 2023 16:07:32 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5007f3d3235so472905e87.2
        for <rcu@vger.kernel.org>; Thu, 24 Aug 2023 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692918450; x=1693523250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i0gAwhqOWZT0diMDK7kLkhF5OyNhIxTRw4Qs38qP1Eo=;
        b=Soeu+ivRN6Fyjs15dnt25q9GyyVqV/LhqdPPPbJ/bLzb5EKpEuNPHHO+Zlya3NWdaU
         6IR9vCEkM2qXT+4JkknTa5kyBQJh6xbdQNtzcBzItAtLwWLUNMTTLEdcnPyH9ANv1Gi3
         DJ+GM4xunJ1O4N56AP0Fz8TFy1ZGxJhSxursc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692918450; x=1693523250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0gAwhqOWZT0diMDK7kLkhF5OyNhIxTRw4Qs38qP1Eo=;
        b=CdpFdn8hPe7nuHe9mVTMFCH/DEuDGbcXKl9jX7qeTG2mLbCWT93TIEqfzibHHjrY1D
         EF+42d2HKZ8Yl7c3Inf8s6WxM4an/+c2LI36yvCbBmDExN1quAT0PRHxfSj5gYBQouuH
         C2/yD8y49nD37sbNAQ63hQRiT2+f11cGE3I+xWG980mXPrAeuQZmlrGL0j2sgXOzItbT
         b0LMxWHX2Hg0+29vraNEKPo8M8RtzXgKOee2LoITuFv1oqDad2fI54AYglpn2eCqpFVz
         Y/9SGJhH3StlnxMPEUUz/EszkBzwhA8wQSG/+9BdC85QP0iWpoMsPuVMYrWtY7zd3HfB
         efow==
X-Gm-Message-State: AOJu0YyMh58FWoRUARdv0h+Mo3f3kKyLDxM4+SNvZg73WtE8ZtW1EvIl
        eteWMgsbVpSgze1JoBTXal+rnB1pPMjaA36TqTWopbRD
X-Google-Smtp-Source: AGHT+IEXdw/T0NnWOwvcYmEPMeAg5kEVZ2c3idPNfZPoG6jTO6SyJu4eHT/3hD/pBjeAQUJX4OXY9Q==
X-Received: by 2002:ac2:5f41:0:b0:4f8:72fd:ed95 with SMTP id 1-20020ac25f41000000b004f872fded95mr9620078lfz.22.1692918450473;
        Thu, 24 Aug 2023 16:07:30 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id g6-20020ac25386000000b004fe1f1c0ee4sm47014lfh.82.2023.08.24.16.07.29
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 16:07:29 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso4683571fa.1
        for <rcu@vger.kernel.org>; Thu, 24 Aug 2023 16:07:29 -0700 (PDT)
X-Received: by 2002:a2e:9bcc:0:b0:2bc:bc70:263f with SMTP id
 w12-20020a2e9bcc000000b002bcbc70263fmr9572475ljj.0.1692918449041; Thu, 24 Aug
 2023 16:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <79cb1ec7-08ec-40d2-bbb4-ce40b684f1a4@paulmck-laptop>
In-Reply-To: <79cb1ec7-08ec-40d2-bbb4-ce40b684f1a4@paulmck-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Aug 2023 16:07:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whn=hcK3E+je=QjJ-b0CYbp2aY6sQBJGjFsX34L7wO+xA@mail.gmail.com>
Message-ID: <CAHk-=whn=hcK3E+je=QjJ-b0CYbp2aY6sQBJGjFsX34L7wO+xA@mail.gmail.com>
Subject: Re: [GIT PULL] scftorture changes for v6.4
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        rcu@vger.kernel.org, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 24 Aug 2023 at 15:06, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Once the merge window opens, please pull these scftorture changes:

Heh, hedging your bets a bit?

This email had "for v6.4" in the subject, the CSD-lock one had "for
v6.5", and the RCU one had "for v6.6".

But I'll do them all in the next merge window, never fear.

              Linus
