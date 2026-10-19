Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422754;
	b=M+4IpuK3uXgNUgaUOe7LYTBdsGmDFx9S8NgAQo+NxV52iu3lBMDVQ9r4p6y6Za/o+RtO
	 j3x+csv+fTYTSSJLyjMOpwo0wH22GFe6b86rdo78XmIz0jhgLY/wyrYRS/PwKAzLQretb
	 v//+8mS3dfOSTxvdycZu3k/fKBdYHcWJGsVuvTX9ZLU+tcvDG7Bw3OWCqFxL+juYXD7GZ
	 MgABuDwQ9byrXgwbwoyX1pfEEEsNwFqQlV0f+dj0s1caZhBnTv4jBXS4mCOm/lgtTxRA6
	 +FQd3D3POJEyvrYnvvevGjFXNFQBFYphDNh1Ner41JhN2d4cXpjRJ4c7ai/3nler6ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422754;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RqMiwNrNvXh5GTQNf5CbmkH7lo3XiBlAJIsepE6Yk1Y=;
	b=q+ARuiylmJcT92FIsKflHVzyERFbntwpuOYjVg/NSMYFJ52viwlBGOdtf77RmH2gVQ9H
	 rJrdaKNnoAr++HKLY832DJdZKiaPBmLhnjMpLkJVB56vygocdjweF0U1RDmcApDhmR5pt
	 Nh13GHzhDe/MRUnp29+8cRPnoTe4Uv0UMsRNsFYfVm/UBdyzpUrb7v0uAnGEvZJ+td9yL
	 EQGrIQmF76GB7mItT9JwAHbLGLyBJxmUJGZbih2udlHbVkdDPVtfnGlTb5mwRJJzJXw5v
	 a6C8HzhrnErncT58+9NeqK9+2CbE9NvNHIcX40p8TSgXOKZfcDIPboHKRkO1bQ9zO0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=rp7lkRsF;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=YjxLj5UB;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD36098A0D;
	Mon, 19 Oct 2026 15:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97AD36098A0D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=rp7lkRsF;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=YjxLj5UB
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792422751; bh=RqMiwNrNvXh5GTQNf5CbmkH
	7lo3XiBlAJIsepE6Yk1Y=; b=rp7lkRsFVw84fXeEVT6DW+0FtZqF7z0IaBHDWwxOJ9mxkc+zG+
	6J429ltznkrG79JiYuvVJOMkrMDF8B7KEiL2PJ/qx/ClddCvzXzWDvFy0H8yRU3LkJoYblvI7LF
	aoDBUpgxbHwezGRTA8Bt8LkjgcHfyXCEsQlf1HwYOI9mm/ndzj3iSzKVHKHLiiarxKuROMAkjq8
	dzpoxdlHqO5ik8nq1+ULO14MST6Tn2ASKd9qObD6fbep3py2WHicdRLfR7KZx13gqTGtkg3bqFM
	TH7zxKkMSHvSjKrzOWyao6KgdBN1APLv5PwDQBxcTQs5jRYPIvO9Ck5HrZw6Pyl7FoQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792422751; bh=RqMiwNrNvXh5GTQNf5CbmkH
	7lo3XiBlAJIsepE6Yk1Y=; b=YjxLj5UB5NHsSwNRPzGbYpNe2BZB/uX2RWtNWtYIAAuny3xhuc
	M0x9v5mWGNDPdtTUynqmoDj4YafgidjPHeDA==;
Date: Mon, 19 Oct 2026 16:12:31 +0100
From: Bradley Morgan <brads@mainlining.org>
To: qiang.zhang@linux.dev
CC: boqun@kernel.org, frederic@kernel.org, joelagnelf@nvidia.com,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org, paulmck@kernel.org,
 rcu@vger.kernel.org, urezki@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_doc=3A_Update_recent_RC?=
 =?US-ASCII?Q?U/SRCU_API_additions_to_whatisRCU=2Erst?=
In-Reply-To: <20261019122209.15604-2-qiang.zhang@linux.dev>
Message-ID: <DD585FED-EB1E-4D71-B6DB-CFA4A15D4DCF@mainlining.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 19 October 2026 13:22:09 BST, Zqiang <qiang.zhang@linux.dev> wrote:
>The following commit introduces some new RCU/SRCU APIs:
>
>Commit 'd3f52f53a562 ("srcu: Create an SRCU-fast-updown API")'
>Commit 'dab06d6f9379 ("srcutree: Add an atomic Tree SRCU")'
>Commit 'cacadb630375 ("srcu: Add guards for notrace variants of SRCU-fast
>readers")'
>Commit 'fa8a2d55139f ("srcu: Add lock guard for srcu_fast_updown flavor")'
>Commit '954c0d741299 ("srcu: Add guards for SRCU-fast readers")'
>
>This commit therefore update thems and some missing RCU related APIs
>to whatisRCU.rst.
>

Since this relates to my patch, and it looks good:

Acked-by: Bradley Morgan <brads@mainlining.org>


>Signed-off-by: Zqiang <qiang.zhang@linux.dev>
>---
> Documentation/RCU/whatisRCU.rst | 24 +++++++++++++++++++++---
> 1 file changed, 21 insertions(+), 3 deletions(-)
>
>diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
>index e6767baff2d3..fe9dc3948690 100644
>--- a/Documentation/RCU/whatisRCU.rst
>+++ b/Documentation/RCU/whatisRCU.rst
>@@ -1084,8 +1084,9 @@ RCU::
> 	rcu_dereference			call_rcu
> 	rcu_dereference_check		call_rcu_hurry
> 	rcu_dereference_protected	kfree_rcu
>-	rcu_read_lock_held		kvfree_rcu
>-	rcu_read_lock_any_held		kfree_rcu_mightsleep
>+	rcu_dereference_all		kvfree_rcu
>+	rcu_read_lock_held		kfree_rcu_mightsleep
>+	rcu_read_lock_any_held		kvfree_rcu_mightsleep
> 	rcu_pointer_handoff		cond_synchronize_rcu
> 	unrcu_pointer			cond_synchronize_rcu_full
> 					cond_synchronize_rcu_expedited
>@@ -1209,13 +1210,23 @@ SRCU::
> 	srcu_read_lock_nmisafe		start_poll_synchronize_srcu
> 	srcu_read_unlock_nmisafe	start_poll_synchronize_srcu_expedited
> 	srcu_read_lock_notrace		poll_state_synchronize_srcu
>-	srcu_read_unlock_notrace
>+	srcu_read_unlock_notrace	synchronize_srcu_atomic
> 	srcu_down_read
> 	srcu_up_read
> 	srcu_down_read_fast
> 	srcu_up_read_fast
>+	srcu_read_lock_fast_updown
>+	srcu_read_unlock_fast_updown
>+	srcu_read_lock_atomic
>+	srcu_read_unlock_atomic
> 	guard(srcu)()
>+	guard(srcu_fast)()
>+	guard(srcu_fast_notrace)()
>+	guard(srcu_fast_updown)()
> 	scoped_guard(srcu)
>+	scoped_guard(srcu_fast)
>+	scoped_guard(srcu_fast_notrace)
>+	scoped_guard(srcu_fast_updown)
> 	srcu_read_lock_held
> 	srcu_dereference
> 	srcu_dereference_check
>@@ -1229,9 +1240,16 @@ SRCU: Initialization/cleanup/ordering::
> 	DEFINE_STATIC_SRCU
> 	DEFINE_SRCU_FAST        // for srcu_read_lock_fast() and friends
> 	DEFINE_STATIC_SRCU_FAST // for srcu_read_lock_fast() and friends
>+	DEFINE_SRCU_FAST_UPDOWN		// for srcu_read_lock_fast_updown() and friends
>+	DEFINE_STATIC_SRCU_FAST_UPDOWN	// for srcu_read_lock_fast_updown() and friends
>+	DEFINE_SRCU_ATOMIC		// for srcu_read_lock_atomic() and friends
>+	DEFINE_STATIC_SRCU_ATOMIC	// for srcu_read_lock_atomic() and friends
> 	init_srcu_struct
> 	init_srcu_struct_fast
>+	init_srcu_struct_fast_updown
>+	init_srcu_struct_atomic
> 	cleanup_srcu_struct
>+	smp_mb__after_srcu_read_lock
> 	smp_mb__after_srcu_read_unlock
> 
> All: lockdep-checked RCU utility APIs::
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
