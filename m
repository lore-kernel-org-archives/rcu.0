Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B17C71153
	for <rcu@archiver.kernel.org>; Sun,  3 Sep 2023 02:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbjICCDp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 2 Sep 2023 22:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjICCDo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 2 Sep 2023 22:03:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E6D180
        for <rcu@vger.kernel.org>; Sat,  2 Sep 2023 19:03:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-307d58b3efbso232770f8f.0
        for <rcu@vger.kernel.org>; Sat, 02 Sep 2023 19:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693706619; x=1694311419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGDSQJiXQuoyWps/ytd/2WoWtJYP1mDXQdaj2jxTaeg=;
        b=dLMQrH/8OwZlxhwU1EibFBg03eD6pe2Z3+LrC41KcQwMmaAdAdPSe7dhgaNDQvT7Mv
         jyP6FrqV78hYpHUtlwU1mC4E7FgdMRRW1rRbT1qUyuhllzlK1Rj5YOhGnCjptHHA6sJz
         /hZwfF4haFBCtkLeSAVAhGXIFM1sjf0XquByk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693706619; x=1694311419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGDSQJiXQuoyWps/ytd/2WoWtJYP1mDXQdaj2jxTaeg=;
        b=kNWK+UUFAaNCt6CJD09YV+55Os+SSpxydi+S+6hHCFBtNwec2j21xiMNYQzrJ4kEh4
         7wnznQ0HSqTmsgWNwEOZXv01VZyqwYxs6CUKVuz5awcTprjxHkHseJBNMkC+Mx3sPbd1
         442QpyNvJYUNMnkXnxsbJD8/M5W1urH5het7JwzPCFTvJzWNnFTo1gugXhcnZv55pL7j
         mh7o4tUMm/CDjVjfcS/CBMSukiWRV+2JYvVw1p/3VqWh11lOGvOzqgpxA1lO16V/xCOj
         CU5nnMfWsGxvENfXTYvByz1Mxx1HrFNF9vuE2xDFP87FG0yIAKsNVpdVz5py3rT4IGTo
         kZ6w==
X-Gm-Message-State: AOJu0Yyw5s094dfGq/Lb3IXUSgY8QxnVZ6VmmcRpef9xBLxRPt/2yKD9
        TU3a4ExmS4+HHU8+CCBw7n/sfNRGgrWQMab5iXwiZA==
X-Google-Smtp-Source: AGHT+IGQsIsQewNGMCxECvHe8qzSJVIhzfT9nCmpKPZkBWgm+NlAYIiR8ejmECFslO7nvNY8+QSayp+yc9vuJD8tiT4=
X-Received: by 2002:adf:ebcd:0:b0:313:eaf5:515 with SMTP id
 v13-20020adfebcd000000b00313eaf50515mr4322055wrn.6.1693706619010; Sat, 02 Sep
 2023 19:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230830110402.386898-1-joel@joelfernandes.org>
 <20230830110402.386898-2-joel@joelfernandes.org> <20230902182828.e42c6ec7b4a7beb1e4b2b042@linux-foundation.org>
In-Reply-To: <20230902182828.e42c6ec7b4a7beb1e4b2b042@linux-foundation.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 2 Sep 2023 22:03:28 -0400
Message-ID: <CAEXW_YQB4qahh4FZrtw3AOsxwRw7-Bd1YXULCBOE2K9j81Oqag@mail.gmail.com>
Subject: Re: [PATCH 2/2] rcu: Dump vmalloc memory info safely
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Sep 2, 2023 at 9:28=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 30 Aug 2023 11:04:00 +0000 "Joel Fernandes (Google)" <joel@joelfe=
rnandes.org> wrote:
>
> > Currently, for double invoke call_rcu(), will dump rcu_head objects
> > memory info, if the objects is not allocated from the slab allocator,
> > the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
> > need to be held, since the call_rcu() can be invoked in interrupt conte=
xt,
> > therefore, there is a possibility of spinlock deadlock scenarios.
> >
> > And in Preempt-RT kernel, the rcutorture test also trigger the followin=
g
> > lockdep warning:
>
> "possibility of deadlock" sounds like something -stable kernels would
> like to have fixed.
>
> Did you consider the desirability of a -stable backport?
>
> If so, are we able to identify a suitable Fixes: target?

Good point, it should be:
Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")

I am currently reworking the patch as Vlad was also concerned about
(the existing) issue of accessing vm_struct fields without holding the
lock [1].

I will add this fixes tag to both patches for the v3 on the respin.

Thanks!

 - Joel
