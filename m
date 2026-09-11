Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE7A40BCA1;
	Fri, 11 Sep 2026 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168790; cv=none; b=iyes+xLZtzydilHxUeoRtcR1r7ZPLWKYSkTG+JN+5NxgWssNJYxm6Bs1/kZzVgAyIFGWrT7qonot3hxeIM5xeAtl5XfLmKjSF0GqLSVLdLfWkD3sRgXGiL8f4XZ3UdLDQqGSWD60i4eABUXnCmnHkJd6XHnDPRiYeqHsapYd6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168790; c=relaxed/simple;
	bh=Y9LPj0y/C6QE3QL6VvUqmbuJaOvBwzqeZD+zfu+ZeNs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bEbKGyvDn9qXLfrbGEt6q05gS7Wh7tMan7d7jGuYFr3FXyK0U2afJRHioAJvL3+7jDzrxhUMLjQmMvdZrIofCavSuAKoyqFgmabKeTCWAFTBpfPgnpBZlAniLe3FIbX/ALUkE7lZeR9f/5JZGyPlYFTeHcE61n1VUnAcrBPKvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Srm243Z9; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qRkiO5S0; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Srm243Z9";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qRkiO5S0"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789168782; bh=CjgeACZH/x3FEfwJCVPAdZD
	UqiJPQHS9uyAuUMefhqA=; b=Srm243Z9kn6VLJfTiQYuWtB7tBfaDbHoWhmY3iBwGaJt6zS4P5
	jf25xi8tKYoszhIdKMCZWesgScWkHB2eyW+XzxTkEHxH9dfVjA4a2hhVYOTcaRtRxLrReJowpKB
	dIrN6ls+Nz4Jaq8HxfdwqgpMxX09ePfeWxihh2nMK+A2o3F+hiI9k1yp7ODJuFR1bNMcOC8V4vl
	MCdSjBswJhDtRuwKdoihrUkkhRsuMchp5FBlnUtMXYqpccswJM7WUoFXX/V4/jadUgIdHOJI5vC
	JKDWXGN2G4I5GGYpeWOjiJKm5JTD58hAHQdFd83M9a8iFjmxtS+8eqAdOK3EoUYI1jw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789168782; bh=CjgeACZH/x3FEfwJCVPAdZD
	UqiJPQHS9uyAuUMefhqA=; b=qRkiO5S0JsvRZcJiiTaa46kya51uVQRaMnhOPz3Z9iUwrd/kU6
	njZfcE6psVVqRsnOmjQjDugWaO6Nvq7jSwCg==;
Date: Sat, 12 Sep 2026 00:19:41 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
CC: kunwu.chan@gmail.com, jiangshanlai@gmail.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_srcutiny=3A_Add_lockdep_and_earl?=
 =?US-ASCII?Q?y-boot_checks_to_synchronize=5Fsrcu=5Fatomic=28=29?=
In-Reply-To: <5383fa3d-7d3f-4baf-b72e-cfb1b1e7a815@paulmck-laptop>
References: <20260911160913.2859713-1-kunwu.chan@gmail.com> <3CFBAB18-70BF-48DA-9CE2-77F7C89F2DCC@mainlining.org> <5383fa3d-7d3f-4baf-b72e-cfb1b1e7a815@paulmck-laptop>
Message-ID: <D781BC3F-714D-4FF1-81C2-0419B77DAF85@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 12 September 2026 00:12:25 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Fri, Sep 11, 2026 at 10:18:04PM +0100, Bradley Morgan wrote:
>> On 11 September 2026 17:09:13 BST, Kunwu Chan <kunwu.chan@gmail.com>
>wrote:
>> >Add the RCU_LOCKDEP_WARN and early-boot check that the Tree version
>> >gained, srcu_lock_sync() was already present.
>> >
>> >Suggested-by: Zqiang <qiang.zhang@linux.dev>
>> 
>> Ok.
>> 
>> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>
>Applied, thank you!
>
>> >Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>> >---
>> > kernel/rcu/srcutiny.c | 6 ++++++
>> > 1 file changed, 6 insertions(+)
>> >
>> >diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
>> >index 99f8bfd98b04..76411562366f 100644
>> >--- a/kernel/rcu/srcutiny.c
>> >+++ b/kernel/rcu/srcutiny.c
>> >@@ -361,6 +361,12 @@ void synchronize_srcu_atomic(struct srcu_struct
>*ssp)
>> > 
>> > 	srcu_lock_sync(&ssp->dep_map);
>> > 
>> >+	RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
>> >+			 "Illegal synchronize_srcu_atomic() in same-type SRCU read-side critical section");
>> >+
>> >+	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
>> >+		return;
>> >+
>> 
>> Wow!
>
>If you think that this one is fun, take a look at the implementation of
>synchronize_rcu() in kernel/rcu/tiny.c.  ;-)


void synchronize_rcu(void)
{
    RCU_LOCKDEP_WARN(...);
    preempt_disable();
    WRITE_ONCE(rcu_ctrlblk.gp_seq, rcu_ctrlblk.gp_seq + 2);
    preempt_enable();
}

Hah!

>
>							Thanx, Paul
>
>> > 	if (IS_ENABLED(CONFIG_PREEMPTION))
>> > 		synchronize_rcu(); // Needed for RCU Tasks Trace to imply RCU grace period.
>> > 				   // And in Tiny RCU, it is near zero cost and doesn't block.
>> >
>> 
>> --- Thanks!
>>
>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
