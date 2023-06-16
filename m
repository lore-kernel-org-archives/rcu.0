Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81633EB64D7
	for <rcu@archiver.kernel.org>; Fri, 16 Jun 2023 18:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjFPSux (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Jun 2023 14:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFPSuw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Jun 2023 14:50:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CAB30FB
        for <rcu@vger.kernel.org>; Fri, 16 Jun 2023 11:50:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98220bb31c6so156151366b.3
        for <rcu@vger.kernel.org>; Fri, 16 Jun 2023 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686941450; x=1689533450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn/qWt62UcmmaaPkId4UDrJc21A6804tWR7mlup1U/g=;
        b=bI88/h029pU5pmJdvUquADcF/Hv3Cn+FDaQYxd2XC5ACQIY2/p6Borz3hEMGKS2pY1
         cskFCeIBlU4rmEuhjDPFVQwO4Icz3Bmkli6V7si6jhkgRZJ3Rr7ZggEDy1IOLUDgpoy6
         3CgkFWXbuuL5mr2BHnEuOxuQolxs9qRGE7tlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686941450; x=1689533450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fn/qWt62UcmmaaPkId4UDrJc21A6804tWR7mlup1U/g=;
        b=SnC0SQ5a4BojxLnOklnL7ocrpSXDOY0xmakW/hA350pInixTygQhAQHxpR7Xp8Hl/o
         qe2dzVcUV0yw0GWlOzkUGv47VT9gOx5uDElAUl5h0TxE7ZULyNF4qHJm/1bipIsSDNXL
         sTBA7mt/aXGRyf3TrrSWfNZgHFSNb/9EPBFU71pzW1eFxLmi7VTWV9ABKJZlA/wrMCT0
         VRpxaMP5FndG/2PSQfO8ui3LExfKHhk5lrsgjXs4g/63gmS8YHjZK02I8AW/OYCMFzaS
         gPOMlcmNXsBszkpxS733O2eQ+3vVmCxJlb0vHsS44hh2PsA0lGGPC5uD+aq6j6oLTyx/
         9Wxw==
X-Gm-Message-State: AC+VfDz0oX2H4zKhxTH2kLkl+Y/EP1Zo0iYgLpq/K3UuatgSDyyMVKaf
        tACf75kIhK2IEe8q9jYhoT7UEP6MFw/lqqpfAVFq+6p/
X-Google-Smtp-Source: ACHHUZ7L07yIWVOnP5A2NBjaFmrAV07R8eLKL2MpmE/M9hLPCE7MDQe4lfBCpEXb8jI9uNWIU86zXw==
X-Received: by 2002:a17:907:97d2:b0:978:8685:71cd with SMTP id js18-20020a17090797d200b00978868571cdmr2989641ejc.71.1686941449741;
        Fri, 16 Jun 2023 11:50:49 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906925300b0096f67b55b0csm11127137ejx.115.2023.06.16.11.50.49
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 11:50:49 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51a3e6a952aso1015514a12.3
        for <rcu@vger.kernel.org>; Fri, 16 Jun 2023 11:50:49 -0700 (PDT)
X-Received: by 2002:aa7:cf19:0:b0:518:922a:bc38 with SMTP id
 a25-20020aa7cf19000000b00518922abc38mr2364463edy.2.1686941448730; Fri, 16 Jun
 2023 11:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <21bdc866-f9ae-4cda-a996-370bde183fd0@paulmck-laptop>
In-Reply-To: <21bdc866-f9ae-4cda-a996-370bde183fd0@paulmck-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Jun 2023 11:50:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPA8d0z2K1huqP0jCKxfmjBG_VYnJtoADeQWsvWLv9UQ@mail.gmail.com>
Message-ID: <CAHk-=wiPA8d0z2K1huqP0jCKxfmjBG_VYnJtoADeQWsvWLv9UQ@mail.gmail.com>
Subject: Re: [GIT PULL] RCU regression fix for v6.4
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rcu@vger.kernel.org, jonathanh@nvidia.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com,
        rafael.j.wysocki@intel.com, mirq-linux@rere.qmqm.pl,
        dmitry.osipenko@collabora.com, sachinp@linux.ibm.com,
        qiang.zhang1211@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 16 Jun 2023 at 09:34, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Yes, it would be nice to abstract this somehow in order to hide it in
> SRCU, but I still don't see a good way of doing this.

Ehh - like we actually do spinlocks in general, perhaps?

Spinlocks always exist. On UP - with no spinlock debugging - it turns
into a zero-sized data structure, and the spin lock/unlock operations
are no-ops.

Why don't you just do the exact same thing with the "struct
srcu_usage". For Tiny SRCU, just make it an empty struct, with an
empty initializer.

IOW, don't "abstract it out". Abstract it IN. Make tiny-rcu still have
it, just as a no-op.

Anyway, I've pulled your fix, but maybe the above would have been the
cleaner solution?

          Linus
