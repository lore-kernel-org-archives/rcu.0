Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681DB547054;
	Wed,  7 Oct 2026 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791389352; cv=none; b=GUH9Jwyv3yPHiDO3kXpeZ35MSDtMrfHdMJWkW47olJWlVxqVEpeQyQQpnn2vByxd6Ey++b+32WwFNdaFOS1tPsNS+zBZhSm7h/Nf7Aj9hqM4oA7mLwhBmgDnQhVHUP1jo5rBDQJcSKoJWp3sqctVYI3tJ5AFGFcjhX8K8uTXWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791389352; c=relaxed/simple;
	bh=m0QsbLPJKJU4C1rSmW4pyhcHRZlcd5NYvWFL2H3HQfI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=IH0OHBsC1lQB2uGYWGBRrHi2sjHAL5R4KAuPAmxdLwwsqfcqBdrAzudKIl8X2q7nYEBwmFCd18WD53eLlIwj2ZJwJAivSqIoKkvjOqLxba1c3Nq0B8/LGgf56B2HigBk/JxrzZDB9vtCOtIel8uRqnXVlrEQOZ+B8JsQrAfQZOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qJecuiMu; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=4R+XlOMq; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qJecuiMu";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="4R+XlOMq"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791389325; bh=8pA3rqv7HWAKOOilda1KMOW
	xQXqtE+qVcTFavK9JL8U=; b=qJecuiMubnNa/7JebPgB8zPxNgCjFAIIS0qpgIglx/g8SIyXvY
	TQq8/ozuE0TvCOaknbiGklj4t7eWdMg7UexaPTwjRhX0RA41ORZMwA1fvShiKmQpCTguLF5i4Sb
	PJjljShv7vN63OxkR454Vr5ew66DA3o42uI8ZsDene8UZCAqgAGCweJurrSk59g3pv+O8Xxmtin
	zNg2+d3DrXOyfVK7/uHCyoXWpPBZmSkjDuLRnnum7s0sFqe0dxvjb01V3w3sHcc7oUlPk00ebrr
	09QqLq2DRkEB/d5COYTgOxM0U2VmONPRTzC8JoXCzDRuDqUswnKWjRipGPJU5ylteew==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791389325; bh=8pA3rqv7HWAKOOilda1KMOW
	xQXqtE+qVcTFavK9JL8U=; b=4R+XlOMqXzHlVPVDflt8a+atWxk7wMUuTwWhfRh0U2On9ECb0T
	vWXvCBP2C49A1OuLDhdPLJh5/qMAM5ka+lDQ==;
Date: Wed, 07 Oct 2026 17:08:46 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Boqun Feng <boqun@kernel.org>, Kunwu Chan <kunwu.chan@gmail.com>,
 Wang Lian <lianux.mm@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 rcu@vger.kernel.org, lkmm@lists.linux.dev, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [BUG] Splat during modest hazptrtorture run
In-Reply-To: <631c13bc-671e-4cf3-b466-0408d7600ab2@paulmck-laptop>
References: <1f885062-4905-4d9c-9293-615c145d2d6b@paulmck-laptop> <5b5dbb90-69ad-4a8f-8583-f5ba162744d3@efficios.com> <631c13bc-671e-4cf3-b466-0408d7600ab2@paulmck-laptop>
Message-ID: <D815461A-028E-47D4-853A-A0A543991FE5@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 7 October 2026 16:59:36 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Wed, Oct 07, 2026 at 03:09:27AM -0400, Mathieu Desnoyers wrote:
>> On 2026-10-06 19:40, Paul E. McKenney wrote:
>> > Hello!
>> > 
>> > This is all new code, so the bug could be anywhere.  So you all need
>> > to know.  ;-)
>> > 
>> > I got this from the NOPREEMPT variant of hazptr during a nominal
>> > "--duration 60" run of torture.sh on x86 with the guest OS split
>across
>> > two NUMA nodes:
>> > 
>> > [  137.765104] WARNING: kernel/rcu/hazptrtorture.c:658 at
>hazptr_torture_stats_print+0x25b/0x4f0, CPU#1: hazptr_torture_/136
>> > [  137.768647] Modules linked in:
>> > [  137.768891] CPU: 1 UID: 0 PID: 136 Comm: hazptr_torture_ Not
>tainted 7.3.0-rc5-00661-ga1f1e4890d1d-dirty #193 PREEMPTLAZY
>> > [  137.769683] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>BIOS 1.16.3-6.el9 11/05/2023
>> > [  137.770319] RIP: 0010:hazptr_torture_stats_print+0x25b/0x4f0
>> > [  137.770735] Code: 48 83 c4 20 e8 86 44 fe ff 41 83 fd 01 7e 23 48
>c7 c6 6e 85 17 b0 48 c7 c7 db 27 17 b0 e8 6d 44 fe ff f0 ff 05 76 6e 0a 02
>90 <0f> 0b 90 4c 8b 64 24 70 48 c7 c7 73 85 17 b0 e8 51 44 fe ff 48 8b
>> > [  137.772061] RSP: 0018:ffffa738004ffdf0 EFLAGS: 00010202
>> > [  137.772435] RAX: 0000000000000004 RBX: ffffa738004ffe08 RCX:
>0000000000000027
>> > [  137.772950] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>0000000000000001
>> > [  137.773455] RBP: ffffa738004ffe60 R08: 4000000000001236 R09:
>ffffffffb01727df
>> > [  137.773980] R10: 0000000020212121 R11: 0000000020212121 R12:
>0000000000000000
>> > [  137.774479] R13: 0000000000000002 R14: 000000000002ffd6 R15:
>0000000000034f03
>> > [  137.775000] FS:  0000000000000000(0000) GS:ffff999c2e502000(0000)
>knlGS:0000000000000000
>> > [  137.775578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [  137.776001] CR2: 0000000000000000 CR3: 0000000008830000 CR4:
>00000000000006f0
>> > [  137.776512] Call Trace:
>> > [  137.776700]  <TASK>
>> > [  137.776863]  ? __pfx_hazptr_torture_stats+0x10/0x10
>> > [  137.777207]  hazptr_torture_stats+0x25/0x70
>> > [  137.777508]  kthread+0xd9/0x110
>> > [  137.777751]  ? __pfx_kthread+0x10/0x10
>> > [  137.778017]  ret_from_fork+0x1bd/0x220
>> > [  137.778285]  ? __pfx_kthread+0x10/0x10
>> > [  137.778560]  ret_from_fork_asm+0x1a/0x30
>> > [  137.778849]  </TASK>
>> > [  137.779007] ---[ end trace 0000000000000000 ]---
>> > 
>> > I have not yet seen this during a PREEMPT run.  Line 658 of
>> > hazptrtorture.c is the WARN_ON_ONCE() below:
>> > 
>> > 	if (i > 1) {
>> > 		pr_cont("%s", "!!! ");
>> > 		atomic_inc(&n_hazptr_torture_error);
>> > 		WARN_ON_ONCE(i > 1); // Too-short grace period
>> > 	}
>> > 
>> > Any thoughts on what might be causing this?
>> 
>> Hi Paul!
>> 
>> Can you share which tree and branch (commit) this is running ?
>> 
>> Does it include my fix from this series ? That would be patch 1 of:
>> 
>>
>https://lore.kernel.org/lkml/20260927155134.4740-1-mathieu.desnoyers@efficios.com/
>
>Ah, no, I somehow got the impression that this series was going to be
>updated, so did not apply it.  Apologies!
>
>I will pull these in.
>
>> Does it run the additional series from Kunwu Chan found at
>>
>https://lore.kernel.org/lkml/20261002170847.3653663-1-kunwu.chan@gmail.com/
>?
>
>No, but if you are good with it I will pull it in.
>
>May I add your Acked-by or Reviewed-by?

Sorry to impede but I'd be fine with it going in, I'll add my A-B for this:

Acked-by: Bradley Morgan <brads@mainlining.org>


>
>							Thanx, Paul
>
>> Thanks,
>> 
>> Mathieu
>> 
>> > 
>> > For that matter, can anyone else reproduce this?
>> > 
>> > 								Thanx, Paul
>> 
>> 
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com

--- Thanks!
"I'm not a very positive person" - Linus torvalds
