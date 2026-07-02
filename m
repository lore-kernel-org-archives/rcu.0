Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275D64A2E01
	for <rcu@vger.kernel.org>; Thu,  2 Jul 2026 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000445; cv=none; b=kvaJBPyYgIHtqGDvIZ4m4yHYwd5Klgq6MRgUJd7FTly0NkwxHn8tAzgymOaKr7b6ITm5bw83oCz888ehvcIvoTpd2V0eR3ldqJWXpY3f9X3VNlnVH30EUwSXPzZOYAdoo6OABFdwMmlTfTtjAAOIUbeUo6lEezuHLkLCpUONxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000445; c=relaxed/simple;
	bh=Qzxj6NI2eUmZ85Vo5IDuitsP548Din1ADw5yilcFrZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YX6rif3vlRb5zceJJOTAyUzntsaf36PZTGJK7f29f4Fqy5RmyHqgVq0/u0MKoAMv5IRP3Y4um3B9MLU+zMxdVWN31IRW+Rq2OlrFlnFYXU67eiNt2/+kiAd+/2x9UdWfbm85oUAXwtDjhWxwptJzGeJczuY8kxyDmuR0rCn+xFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Ky/aebPr; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Ky/aebPr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1783000432; x=1783259632;
	bh=hQEN5Te5oy2MY7ORwmZkU4gkU3OPngbAM52hvRw8m1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ky/aebPrcEOKWs0UNABK6w5WERQ3tRoGofjMV54LY6DIzZBiTrbwjEAQlG9wK53/x
	 kbEpG4EWc0xnP2fsC3IZONP2ty9CGrVDVYiiRQh01S8xIak0wXVEChrJSGSf1GxJ92
	 nHVRLugJKk5yvZH1nutp23cMRZL/DIWLPzT0e5gBU4Y4SNLRYVp2lvXUdHE5byvDgI
	 bpmsEjXy2lGP+nyvcTdWKwSL3CuIWDVflF33hR2sP++qbek0qhI8iAlwp+2esNPYVD
	 S+ksurCCmV0QeCqpNa9q5x7c5+NYkRMO5tuIQ5McYMwA0gGFzf5zVmEmk1ovVljR2X
	 KeYx3RGmRl0IQ==
X-Pm-Submission-Id: 4grddl4mlvz2Sd37
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	fujita.tomonori@gmail.com,
	tamird@kernel.org,
	jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v10 0/5] rust: add SRCU abstraction
Date: Thu,  2 Jul 2026 16:53:34 +0300
Message-ID: <20260702135345.44303-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260613065348.96750-1-work@onurozkan.dev>
References: <20260613065348.96750-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jun 2026 09:40:06 +0300=0D
Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
=0D
> The immediate motivation is the Tyr reset infrastructure [1] which needs=
=0D
> to serialize reset sensitive hardware access against reset and teardown=0D
> paths. That reset series started to require many independent dependencies=
=0D
> so this SRCU support is split out as a standalone Rust API to keep the=0D
> reset series focused on the reset logic and easier to review, rebase and=
=0D
> land.=0D
> =0D
> =0D
> Changes since v9:=0D
> =0D
> - SRCU initialization restructuring is now a separate patch (the first=0D
>   one in this series).=0D
> - Comment fix on C initialization functions.=0D
> =0D
> =0D
> Changes since v8:=0D
> =0D
> - Refactor srcu init handling to provide better init API (motivated by=0D
>   the "mutex.h" initializers.=0D
> - Use warn_on! instead of pr_warn! on leaked guard detection.=0D
> =0D
> =0D
> Changes since v7:=0D
> =0D
> - Moved synchronize_srcu() call inside "if srcu_readers_active()"=0D
>   condition in "impl PinnedDrop for Srcu".=0D
> - Improved comments on the synchronize_srcu() call in=0D
>   "impl PinnedDrop for Srcu".=0D
> =0D
> =0D
> Changes since v6:=0D
> =0D
> - Removed "CONFIG_DEBUG_LOCK_ALLOC" condition from "rust/helpers/srcu.c"=
=0D
>   and created a simple wrapper inside "include/linux/srcu.h" for it.=0D
> =0D
> =0D
> Changes since v5:=0D
> =0D
> - Created separate srcu_readers_active() variants for "srcutiny.h" and=0D
>   "srcutree.h".=0D
> =0D
> =0D
> Changes since v4:=0D
> =0D
> - Exposed srcu_readers_active from C side and wired it to the Rust=0D
>   helpers.=0D
> - Used srcu_readers_active() in SRCU drop and logged with pr_warn if=0D
>   there are leaked guards during the drop.=0D
> =0D
> =0D
> Changes since v3 (which are for Sashiko notes [2]):=0D
> =0D
> - Added rust helpers for srcu_barrier() and synchronize_srcu_expedited()=
=0D
>   so the abstraction builds with CONFIG_TINY_SRCU, where these are=0D
>   static inline functions.=0D
> - Added missing INVARIANT comment in Srcu::new() about why the type=0D
>   invariants hold after successful initialization.=0D
> =0D
> =0D
> Changes since v2:=0D
> =0D
> - Removed closure-based API.=0D
> - Added #[doc(hidden)] on new_srcu macro.=0D
> - Added #[must_use..] on srcu::Guard.=0D
> - Improved the clean-up path (PinnedDrop implementation) which=0D
>   eventually made read_lock safe with leaked guards.=0D
> =0D
> =0D
> Changes since v1:=0D
> =0D
> - Made the owned SRCU read-side guard API unsafe and added a safe closure=
=0D
>   based helper for callers that do not need to keep the guard. This is to=
=0D
>   avoid UB on the C side cleanup_srcu_struct where the SRCU struct is fre=
ed=0D
>   while there are still active guards, which can happen if the caller lea=
ks=0D
>   the guard e.g., with mem::forget().=0D
> - Improved doc comments.=0D
> =0D
> =0D
> v1: https://lore.kernel.org/all/20260428103437.156236-1-work@onurozkan.de=
v=0D
> v2: https://lore.kernel.org/all/20260502162833.34334-1-work@onurozkan.dev=
=0D
> v3: https://lore.kernel.org/all/20260522054228.114814-1-work@onurozkan.de=
v=0D
> v4: https://lore.kernel.org/all/20260525175706.124910-1-work@onurozkan.de=
v=0D
> v5: https://lore.kernel.org/all/20260527174120.510447-1-work@onurozkan.de=
v=0D
> v6: https://lore.kernel.org/all/20260527203615.163688-1-work@onurozkan.de=
v=0D
> v7: https://lore.kernel.org/all/20260528062810.256212-1-work@onurozkan.de=
v=0D
> v8: https://lore.kernel.org/all/20260529114449.112066-1-work@onurozkan.de=
v=0D
> v9: https://lore.kernel.org/all/20260529134004.396743-1-work@onurozkan.de=
v=0D
> =0D
> [1]: https://lore.kernel.org/all/20260416171728.205141-1-work@onurozkan.d=
ev=0D
> [2]: https://sashiko.dev/#/patchset/20260522054228.114814-1-work@onurozka=
n.dev?part=3D2=0D
> =0D
> Onur =C3=96zkan (5):=0D
>   srcu: make init_srcu_struct() consistently wrap __init_srcu_struct()=0D
>   rust: helpers: add SRCU helpers=0D
>   srcu: expose srcu_readers_active()=0D
>   rust: sync: add SRCU abstraction=0D
>   MAINTAINERS: add Rust SRCU files to SRCU entry=0D
> =0D
>  MAINTAINERS              |   3 +=0D
>  include/linux/srcu.h     |  29 ++++---=0D
>  include/linux/srcutiny.h |  13 +++=0D
>  include/linux/srcutree.h |  24 ++++++=0D
>  kernel/rcu/srcutiny.c    |  14 ++--=0D
>  kernel/rcu/srcutree.c    |  36 ++-------=0D
>  rust/helpers/helpers.c   |   1 +=0D
>  rust/helpers/srcu.c      |  35 ++++++++=0D
>  rust/kernel/sync.rs      |   2 +=0D
>  rust/kernel/sync/srcu.rs | 171 +++++++++++++++++++++++++++++++++++++++=0D
>  10 files changed, 282 insertions(+), 46 deletions(-)=0D
>  create mode 100644 rust/helpers/srcu.c=0D
>  create mode 100644 rust/kernel/sync/srcu.rs=0D
> =0D
> -- =0D
> 2.51.2=0D
> =0D
=0D
A gentle ping on this series. Are there any remaining concerns with v10?=0D
=0D
Regards,=0D
Onur=0D
