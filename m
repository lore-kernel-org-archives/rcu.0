Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB715AAB8;
	Mon, 19 Aug 2024 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108837; cv=none; b=j8gBEwWC/v+hcPX9nAuvMzCDmT9gbMvTMeRbjPSos4WBBYDR7+U9Xb7EFKkxMBn6d94PV86uvpSxdgZY+CU5rsyBNs6kNrc48XJWuNQM4OUDQ1VZMe00kTpMoNGxUh1pb2x2iTwz7oOKXWO+IVZD47yeBvKx1zlskMySsWRaZh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108837; c=relaxed/simple;
	bh=1hJitoTM2DBB4K/Bj1rmhFg611FrW2RIraAudvg/Fxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk66AtzRuN2oAe/JmJubhSsm4FwIZilKI9e5oPrzZzPXU5SSB0DdZix1lK4EV1/V1TJJZBm9leMmUFAX9kEcaHbF5ju+b+/BRjSfUrwHQmTt440biPQBZRzchj6Oa2aPtfZsUXG4Ema/e9/Zls5/fY1eB9GZa3a6BSIHJWl3Uu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwbKsZOH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwbKsZOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9103C32782;
	Mon, 19 Aug 2024 23:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724108836;
	bh=1hJitoTM2DBB4K/Bj1rmhFg611FrW2RIraAudvg/Fxs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AwbKsZOHP/fMgusoqlJztbnMhwcgK7z/q21xiD5zSZYKbD7M+0AZha3zaCXNgKuhD
	 Nat5kVVsXADO6fPgWNfu25jo2TGaeEagR5DIz1T9z3uBOiZsBGFUBphf5/+j7GfzKT
	 ziflXx2xAvRr9AzYwzd9SZ9FFaMA+EFTn+XjH9ooJgDR34IXsbu7l7HRciqeNWObK4
	 eIndisUDa6mjsNMqBxiYqAQbP0ZXHGp7ocNY1HKoAybAX8o4OHBUVu7HQvPTcZbn3d
	 qlehWE3iAcfrf7w2rrtU3Yat9baAp06hQjpapC4brtfTtfdijuBJaHLLTwPA1MmPLa
	 1VT6Pp12SDCSA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5185BCE0A01; Mon, 19 Aug 2024 16:07:16 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:07:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] rcu_pending
Message-ID: <0e3c70d8-e2ac-4f71-b155-ef64e25fd415@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819165939.745801-1-kent.overstreet@linux.dev>

On Mon, Aug 19, 2024 at 12:59:26PM -0400, Kent Overstreet wrote:
> New data structure for tracking objects waiting on an RCU grace period.
> Supports regular RCU and SRCU, and possibly other RCU flavors in the
> future. Uses radix trees for tracking pending objects, falling back to
> linked lists on allocation failure.
> 
> This gets us a more general replacement for SLAB_TYPESAFE_BY_RCU, and a
> cleaner and slightly faster backend for kvfree_call_rcu(), and
> in the future a faster backend for call_rcu() as well.
> 
> There's still some small todo items, mentioned in the relevant patches.
> 
> Paul - I'm considering putting this into 6.11 for bcachefs (not the
> patch that switches kvfree_rcu, of course), as I need it rather
> pressingly. Thoughts? I can put it in fs/bcachefs/ if you hate it :)

I am having a hard time imagining it being ready for inclusion in
kernel/rcu by the upcoming (v6.12) merge window, so if you need it then,
you will need to pull it into fs/bcachefs.

Don't get me wrong, it has improved since the June version.  And we
can always move it later, if/when appropriate.

And yes, the kvfree_rcu() changes would need some serious performance
evaluation by the people who benefitted from the changes that make
kvfree_rcu() what it is today.  So let's please defer that one.

Having the equivalent of SLAB_TYPESAFE_BY_SRCU could be attractive,
but I suspect that there are smaller changes that get us that with the
existing slab allocator.

							Thanx, Paul

> Kent Overstreet (9):
>   lib/generic-radix-tree.c: genradix_ptr_inlined()
>   lib/generic-radix-tree.c: add preallocation
>   darray: lift from bcachefs
>   vmalloc: is_vmalloc_addr_inlined()
>   rcu: delete lockdep_assert_irqs_enabled() assert in
>     start_poll_synchronize_rcu_common()
>   rcu: rcu_pending
>   bcachefs: Rip out freelists from btree key cache
>   bcachefs: key cache can now allocate from pending
>   rcu: Switch kvfree_rcu() to new rcu_pending
> 
>  MAINTAINERS                             |   7 +
>  fs/bcachefs/Makefile                    |   1 -
>  fs/bcachefs/btree_key_cache.c           | 406 +++----------
>  fs/bcachefs/btree_key_cache_types.h     |  18 +-
>  fs/bcachefs/btree_node_scan_types.h     |   2 +-
>  fs/bcachefs/btree_types.h               |   5 +-
>  fs/bcachefs/btree_update.c              |   2 +
>  fs/bcachefs/btree_write_buffer_types.h  |   2 +-
>  fs/bcachefs/disk_accounting_types.h     |   2 +-
>  fs/bcachefs/fsck.c                      |   2 +-
>  fs/bcachefs/journal_io.h                |   2 +-
>  fs/bcachefs/journal_sb.c                |   2 +-
>  fs/bcachefs/sb-downgrade.c              |   3 +-
>  fs/bcachefs/sb-errors_types.h           |   2 +-
>  fs/bcachefs/sb-members.h                |   2 +-
>  fs/bcachefs/subvolume.h                 |   1 -
>  fs/bcachefs/subvolume_types.h           |   2 +-
>  fs/bcachefs/thread_with_file_types.h    |   2 +-
>  fs/bcachefs/util.h                      |  29 +-
>  {fs/bcachefs => include/linux}/darray.h |  59 +-
>  include/linux/darray_types.h            |  22 +
>  include/linux/generic-radix-tree.h      | 106 +++-
>  include/linux/mm.h                      |   7 +
>  include/linux/rcu_pending.h             |  27 +
>  init/main.c                             |   2 +
>  kernel/rcu/Makefile                     |   2 +-
>  kernel/rcu/pending.c                    | 623 ++++++++++++++++++++
>  kernel/rcu/tree.c                       | 747 ------------------------
>  kernel/rcu/update.c                     |   1 -
>  lib/Makefile                            |   2 +-
>  {fs/bcachefs => lib}/darray.c           |  12 +-
>  lib/generic-radix-tree.c                |  80 +--
>  mm/vmalloc.c                            |   4 +-
>  33 files changed, 962 insertions(+), 1224 deletions(-)
>  rename {fs/bcachefs => include/linux}/darray.h (66%)
>  create mode 100644 include/linux/darray_types.h
>  create mode 100644 include/linux/rcu_pending.h
>  create mode 100644 kernel/rcu/pending.c
>  rename {fs/bcachefs => lib}/darray.c (57%)
> 
> -- 
> 2.45.2
> 
