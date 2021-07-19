Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC62C07E9B
	for <rcu@archiver.kernel.org>; Mon, 19 Jul 2021 12:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0876115B
	for <rcu@archiver.kernel.org>; Mon, 19 Jul 2021 12:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhGSLnV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Jul 2021 07:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhGSLnU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Jul 2021 07:43:20 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1E7C061574;
        Mon, 19 Jul 2021 04:39:55 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id E3F9CB3F5CE;
        Mon, 19 Jul 2021 14:23:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1626697437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5psd6Gyst7jbmkEY35fCzySbAqC76tMvxDPI72IBLU=;
        b=cQTeim98LKn7CJbBdHfrCSWS7Gz5gbDejjwVrzQDQtHVIIhUvNWfN/pUwkdLmFNc0qLRSq
        XNvt1ZgCZ9ZRF3Abv0BoYfh0kaLDqY4ylhReu8cF9PxgYOfJwGQ0JQbelnzYns9x1wJUp2
        SRhuOZDLzgWOuQUS6G0xqoXx+t4oJ/8=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, paulmck@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Chris Clayton <chris2553@googlemail.com>,
        Chris Rankin <rankincj@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>, gregkh@linuxfoundation.org
Subject: Re: linux-5.13.2: warning from kernel/rcu/tree_plugin.h:359
Date:   Mon, 19 Jul 2021 14:23:55 +0200
Message-ID: <2237123.PRLUojbHBq@natalenko.name>
In-Reply-To: <YPVtBBumSTMKGuld@casper.infradead.org>
References: <c9fd1311-662c-f993-c8ef-54af036f2f78@googlemail.com> <5812280.fcLxn8YiTP@natalenko.name> <YPVtBBumSTMKGuld@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On pond=C4=9Bl=C3=AD 19. =C4=8Dervence 2021 14:16:04 CEST Matthew Wilcox wr=
ote:
> On Mon, Jul 19, 2021 at 02:12:15PM +0200, Oleksandr Natalenko wrote:
> > On pond=C4=9Bl=C3=AD 19. =C4=8Dervence 2021 14:08:37 CEST Miaohe Lin wr=
ote:
> > > On 2021/7/19 19:59, Oleksandr Natalenko wrote:
> > > > On pond=C4=9Bl=C3=AD 19. =C4=8Dervence 2021 13:50:07 CEST Miaohe Li=
n wrote:
> > > >> On 2021/7/19 19:22, Matthew Wilcox wrote:
> > > >>> On Mon, Jul 19, 2021 at 07:12:58PM +0800, Miaohe Lin wrote:
> > > >>>> When in the commit 2799e77529c2a, we're using the percpu_ref to
> > > >>>> serialize
> > > >>>> against concurrent swapoff, i.e. there's percpu_ref inside
> > > >>>> get_swap_device() instead of rcu_read_lock(). Please see commit
> > > >>>> 63d8620ecf93 ("mm/swapfile: use percpu_ref to serialize against
> > > >>>> concurrent swapoff") for detail.
> > > >>>=20
> > > >>> Oh, so this is a backport problem.  2799e77529c2 was backported
> > > >>> without
> > > >>> its prerequisite 63d8620ecf93.  Greg, probably best to just drop
> > > >>=20
> > > >> Yes, they're posted as a patch set:
> > > >>=20
> > > >> https://lkml.kernel.org/r/20210426123316.806267-1-linmiaohe@huawei=
=2Eco
> > > >> m
> > > >>=20
> > > >>> 2799e77529c2 from all stable trees; the race described is not very
> > > >>> important (swapoff vs reading a page back from that swap device).
> > > >>> .
> > > >>=20
> > > >> The swapoff races with reading a page back from that swap device
> > > >> should
> > > >> be
> > > >> really uncommon as most users only do swapoff when the system is
> > > >> going to
> > > >> shutdown.
> > > >>=20
> > > >> Sorry for the trouble!
> > > >=20
> > > > git log --oneline v5.13..v5.13.3 --author=3D"Miaohe Lin"
> > > > 11ebc09e50dc mm/zswap.c: fix two bugs in zswap_writeback_entry()
> > > > 95d192da198d mm/z3fold: use release_z3fold_page_locked() to release
> > > > locked
> > > > z3fold page
> > > > ccb7848e2344 mm/z3fold: fix potential memory leak in
> > > > z3fold_destroy_pool()
> > > > 9f7229c901c1 mm/huge_memory.c: don't discard hugepage if other
> > > > processes
> > > > are mapping it
> > > > f13259175e4f mm/huge_memory.c: add missing read-only THP checking in
> > > > transparent_hugepage_enabled()
> > > > afafd371e7de mm/huge_memory.c: remove dedicated macro
> > > > HPAGE_CACHE_INDEX_MASK a533a21b692f mm/shmem: fix shmem_swapin() ra=
ce
> > > > with swapoff
> > > > c3b39134bbd0 swap: fix do_swap_page() race with swapoff
> > > >=20
> > > > Do you suggest reverting "mm/shmem: fix shmem_swapin() race with
> > > > swapoff"
> > > > as well?
> > >=20
> > > This patch also rely on its prerequisite 63d8620ecf93. I think we sho=
uld
> > > either revert any commit in this series or just backport the entire
> > > series.
> >=20
> > Then why not just pick up 2 more patches instead of dropping 2 patches.
> > Greg, could you please make sure the whole series from [1] gets pulled?
>=20
> Because none of these patches should have been backported in the first
> place.  It's just not worth the destabilisation.

What about the rest then?

git log --oneline v5.13..v5.13.3 -- mm/ | wc -l
18

Those look to be fixes, these ones too.

=2D-=20
Oleksandr Natalenko (post-factum)


