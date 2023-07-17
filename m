Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6B9C0015E
	for <rcu@archiver.kernel.org>; Mon, 17 Jul 2023 18:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjGQSKZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Jul 2023 14:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjGQSKX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Jul 2023 14:10:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831F110DC
        for <rcu@vger.kernel.org>; Mon, 17 Jul 2023 11:10:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98e39784a85so1267138766b.1
        for <rcu@vger.kernel.org>; Mon, 17 Jul 2023 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689617416; x=1692209416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/gQWf/Lh1O+SDhuqheIyYLq5Uzd1/LSa61GJbvgmlmE=;
        b=cSc2Ndd75QixKNlClfA3grdNCC6CP0CoWZDnmMBF5Rc/E5+ro5509TmmTYt8hevhTG
         jHq4BBzbEY2RNM7Q55roh6F9FJ0ysyWlJhdisBjiQwlkIGFOw3IyhhQ8A1obI2G8kune
         UJy4fD2klKIAo/E31SuY7zwSvWWrCSaR+jEKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689617416; x=1692209416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gQWf/Lh1O+SDhuqheIyYLq5Uzd1/LSa61GJbvgmlmE=;
        b=B/gwcyiGZwtPHfXVO1xDH3Nw9xqjCOlPGb1RlPzmifiXfbcoJxgmC1AKYabH2quDA5
         IclzrxVi6Gim2E9N5rN1EnPpkbgD1wSHIAosKdVrCxp9N0K3YYgXixamzTVK5CJAPvlM
         m3aFD2+EvyJ4dlUGLBmH5db627hwmAvTHLgPS+PZbCH1ACqWPt/4C098N0h4G5LOu1rI
         VbIs2lHvgdM9vt1tPE6RUZeLhZSftrxhEvwPBnwVJfw6unpxadVrwL7DuATOtQQktzY6
         of3Evv9RJX8a5eHZYCwk0CdcXvtwzmLtMZq6Dskr6nbilfngUvoL3svztySFSK+z53kY
         eQiQ==
X-Gm-Message-State: ABy/qLaUlZO5p7qNqcPxR6Q4vmtS+u4oUOyHVSLuWywA3js9f36SHFBS
        CFg4hw501V6gyCQQNESFaBKRhRWi4bO9J3HLmDHk5w==
X-Google-Smtp-Source: APBJJlG1bXQSxJ+Fym9a6MY/Qg5A6kmT1RbuD7CDfQ9eXx48Gg3Kvp6HsDtbDEv7HwuVxZHhE6FpEA==
X-Received: by 2002:a17:906:20dd:b0:993:d920:87d2 with SMTP id c29-20020a17090620dd00b00993d92087d2mr11988497ejc.30.1689617415900;
        Mon, 17 Jul 2023 11:10:15 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id b19-20020a170906661300b009920e9a3a73sm9457031ejp.115.2023.07.17.11.10.13
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 11:10:13 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so9982517a12.0
        for <rcu@vger.kernel.org>; Mon, 17 Jul 2023 11:10:13 -0700 (PDT)
X-Received: by 2002:a05:6402:34c2:b0:51e:5206:d69e with SMTP id
 w2-20020a05640234c200b0051e5206d69emr12317922edc.10.1689617412904; Mon, 17
 Jul 2023 11:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop> <20230717180317.1097590-3-paulmck@kernel.org>
In-Reply-To: <20230717180317.1097590-3-paulmck@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jul 2023 11:09:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqX8r3EaaO48dgi=wEBZxJETg1m67HrScRbH1FK7GTRw@mail.gmail.com>
Message-ID: <CAHk-=whqX8r3EaaO48dgi=wEBZxJETg1m67HrScRbH1FK7GTRw@mail.gmail.com>
Subject: Re: [PATCH rcu 3/6] srcu,notifier: Remove #ifdefs in favor of SRCU
 Tiny srcu_usage
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        atthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 17 Jul 2023 at 11:03, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> +// Dummy structure for srcu_notifier_head.
> +struct srcu_usage {
> +       char srcuu_dummy;
> +};
> +
> +#define __SRCU_USAGE_INIT(name) { .srcuu_dummy = 0, }

You really should be able to just do

   struct srcu_usage { };
   #define __SRCU_USAGE_INIT(name) { }

which is something we've done for ages for spinlocks in

    include/linux/spinlock_types_up.h

because while we had a gcc bug wrt empty structures, that was ages ago
(ie "gcc-2.x").

See commit a1365647022e ("[PATCH] remove gcc-2 checks") from 2006.

So we've already had these kinds of empty dummy structs for literally
over a decade in active use. Exactly so that you can avoid having to
use #ifdef's etc, and can just always assume you have a spinlock, even
if it doesn't generate any code or any data overhead.

               Linus
