Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4D232D0E3;
	Thu, 28 May 2026 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994248; cv=none; b=ozpkY54iZ2X1elFEb3OY20rgFMcmAtsFioHKvgMEqsyAC0gpVOc0yPC5V4hhsztx65rU0Dqj8PzsxXNGRqMQ7ttV/Bo/4XgaITHuCTffZnjKxkmfJvUKLwnl59O8fEqey0CeXSZPYDsqjHrAn1WKW+TOkuxEejn7bj/EG0pKPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994248; c=relaxed/simple;
	bh=188yEd6JwGwYNRuFtYHGfjsxDcQ+LYV0ySsKfK+v0pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9WJOc/YLylMCNcASL+mNlflEIHbYpBs6RgobxUNwA1EDCgQOL00cBxa9IWLjMalMjmQJuqDN4t95bGoicAx289AO41UyWhTs0TCM0r4RNJ4WlrG63D0SHEUAO19SoNBLKFl+k8+dSQPd0YUUZA8BKl+h0ANcmswx8TiMq8LZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGgcOZ6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGgcOZ6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42481F000E9;
	Thu, 28 May 2026 18:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779994247;
	bh=ITNMjPlPXhl3WPetAGK0u2eaOxLAfulho76rWJiIYDA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=YGgcOZ6u79EGk5pEO56XtMEJRl3Hvqop44xu8pQbRXrzVabRgF19EEK/ahLMwEMHb
	 WW74LutxCkeVwIWyYzI86XmCLUPbsqLv1KSSGFD2est5eGX1uHGkOycgHJQ0oMex3T
	 ydOL3K73j6RKRL2nZYJ9IHXCSz32RU1jMYJB+JY8kCpMp4o98R4SVsF/ZVejn58UTm
	 HBdxWbIUR061hiwzy4Yiqvn/FBZWV8DA2HHnFN5qBMghaMY3vIqaCrM++5reYZSlZ7
	 WzZ8l2gDxl8fPtQR99g2xtOJIqs5C/48XFzbmBksOsz4npfGfxucmGXWsiN7MEp/50
	 whGO2rz9lO2lQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A0840CE0863; Thu, 28 May 2026 11:50:46 -0700 (PDT)
Date: Thu, 28 May 2026 11:50:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, peterz@infradead.org, fujita.tomonori@gmail.com,
	tamird@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v7 0/4] rust: helpers: add SRCU helpers
Message-ID: <6754912a-598a-4f2c-b62c-12934391f6b2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260528062810.256212-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528062810.256212-1-work@onurozkan.dev>

On Thu, May 28, 2026 at 09:27:32AM +0300, Onur Özkan wrote:
> The immediate motivation is the Tyr reset infrastructure [1] which needs
> to serialize reset sensitive hardware access against reset and teardown
> paths. That reset series started to require many independent dependencies
> so this SRCU support is split out as a standalone Rust API to keep the
> reset series focused on the reset logic and easier to review, rebase and
> land.

For the first two:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

They also pass short rcutorture testing, which is reassuring:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 40 --configs "SRCU-N SRCU-P SRCU-T SRCU-U" --trust-make

> Changes since v6:
> 
> - Removed "CONFIG_DEBUG_LOCK_ALLOC" condition from "rust/helpers/srcu.c"
>   and created a simple wrapper inside "include/linux/srcu.h" for it.
> 
> v6: https://lore.kernel.org/all/20260527203615.163688-1-work@onurozkan.dev
> 
> Changes since v5:
> 
> - Created separate srcu_readers_active() variants for "srcutiny.h" and
>   "srcutree.h".
> 
> v5: https://lore.kernel.org/all/20260527174120.510447-1-work@onurozkan.dev
> 
> Changes since v4:
> 
> - Exposed srcu_readers_active from C side and wired it to the Rust
>   helpers.
> - Used srcu_readers_active() in SRCU drop and logged with pr_warn if
>   there are leaked guards during the drop.
> 
> v4: https://lore.kernel.org/all/20260525175706.124910-1-work@onurozkan.dev
> 
> Changes since v3 (which are for Sashiko notes [2]):
> 
> - Added rust helpers for srcu_barrier() and synchronize_srcu_expedited()
>   so the abstraction builds with CONFIG_TINY_SRCU, where these are
>   static inline functions.
> - Added missing INVARIANT comment in Srcu::new() about why the type
>   invariants hold after successful initialization.
> 
> v3: https://lore.kernel.org/all/20260522054228.114814-1-work@onurozkan.dev
> 
> Changes since v2:
> 
> - Removed closure-based API.
> - Added #[doc(hidden)] on new_srcu macro.
> - Added #[must_use..] on srcu::Guard.
> - Improved the clean-up path (PinnedDrop implementation) which
>   eventually made read_lock safe with leaked guards.
> 
> v2: https://lore.kernel.org/all/20260502162833.34334-1-work@onurozkan.dev
> 
> Changes since v1:
> 
> - Made the owned SRCU read-side guard API unsafe and added a safe closure
>   based helper for callers that do not need to keep the guard. This is to
>   avoid UB on the C side cleanup_srcu_struct where the SRCU struct is freed
>   while there are still active guards, which can happen if the caller leaks
>   the guard e.g., with mem::forget().
> - Improved doc comments.
> 
> v1: https://lore.kernel.org/all/20260428103437.156236-1-work@onurozkan.dev
> 
> 
> [1]: https://lore.kernel.org/all/20260416171728.205141-1-work@onurozkan.dev
> [2]: https://sashiko.dev/#/patchset/20260522054228.114814-1-work@onurozkan.dev?part=2
> 
> Onur Özkan (4):
>   rust: helpers: add SRCU helpers
>   srcu: expose srcu_readers_active()
>   rust: sync: add SRCU abstraction
>   MAINTAINERS: add Rust SRCU files to SRCU entry
> 
>  MAINTAINERS              |   3 +
>  include/linux/srcu.h     |   5 ++
>  include/linux/srcutiny.h |  13 +++
>  include/linux/srcutree.h |  24 ++++++
>  kernel/rcu/srcutiny.c    |   2 +-
>  kernel/rcu/srcutree.c    |  25 ------
>  rust/helpers/helpers.c   |   1 +
>  rust/helpers/srcu.c      |  35 +++++++++
>  rust/kernel/sync.rs      |   2 +
>  rust/kernel/sync/srcu.rs | 166 +++++++++++++++++++++++++++++++++++++++
>  10 files changed, 250 insertions(+), 26 deletions(-)
>  create mode 100644 rust/helpers/srcu.c
>  create mode 100644 rust/kernel/sync/srcu.rs
> 
> -- 
> 2.51.2
> 
> 
