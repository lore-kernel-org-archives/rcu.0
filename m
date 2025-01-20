Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D3C2FB;
	Mon, 20 Jan 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395669; cv=none; b=JI7+7IFmj5cqkX7n1Pq0M8rHhT5S3ZAdm5EdLFWK2GKO3H7mMSHBlZvaDGjzDnNhkyqbHk4IOG4nEpfRGFHdNN5uK0FRJUVRKhL4yTqZktnuzEL6oCprG+RJIfWYhn9myqV6K4ngTaJoBqSa04bL6MIm/5rnFVbts3X5l9yOxCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395669; c=relaxed/simple;
	bh=n9Sdtsq6kD8J5Mzdw3xKwWY1vxXgSaXgzdGMtEG9lkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCV7juvK5/8Z8680DG06damP5u1EuKLjMMB7F3jlzbW6xJp2vM7cGh1dWjwb3fjWxfA3MsmpZONub90Ub1ABFb8py75DrydUZVH7l3Kh/17q8QKMKqkcGyu35OiyDY7lV4qIeIkQao25EByQbV7qVlUt/EPQm0UrXVZscUdejVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSepUlw6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSepUlw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681ACC4CEDD;
	Mon, 20 Jan 2025 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737395668;
	bh=n9Sdtsq6kD8J5Mzdw3xKwWY1vxXgSaXgzdGMtEG9lkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSepUlw6rMhZA+3oGWiS+e89EEA5YS5PuLZ2p/D4vsqT2HgUcCh2AKzEo3XQFCMx3
	 D7UGmVoNRl1k6GG/U2vAAjZZU/iBLq7iVrWshGIvXScOCbKXuNAEK4kTTm4BjMyMGK
	 z0c/Ddj3XojMns1o7HCQ4eXmhJtHv0DKg9kJhL3tIx03Ji51khL0CL+ACH2U/JvKqj
	 ZZp7XJaJw27sMTnfRRD5N2Kr5vfu69c8rCwLDltkdM/qh7lsK8dgIPk8afcV/hQoIO
	 fEUBczUgHob+H1pe2oP+qd3cOTjNW+NCzathm2HyVgRGFxEZj2+Nv38TZSTQ6OZmmq
	 rqozuBUJFNuhA==
Date: Mon, 20 Jan 2025 12:54:26 -0500
From: Sasha Levin <sashal@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Rientjes <rientjes@google.com>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	RCU <rcu@vger.kernel.org>
Subject: Re: [GIT PULL] slab updates for 6.14
Message-ID: <Z46N0lAqUwQ3Z5S6@lappy>
References: <3154387b-c045-401e-800c-f5d05be033e4@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3154387b-c045-401e-800c-f5d05be033e4@suse.cz>

On Fri, Jan 17, 2025 at 03:13:18PM +0100, Vlastimil Babka wrote:
>Hi Linus,
>
>please pull the latest slab updates from:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.14

Hi Vlastimil,

I've ended up pulling quite a few of the 6.14 PRs into linus-next, and
LKFT started hitting the following issue:

<1>[  526.258666] Unable to handle kernel paging request at virtual address 00000007f5b55088
<1>[  526.260217] Mem abort info:
<1>[  526.260902]   ESR = 0x0000000096000005
<1>[  526.261422]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[  526.262197]   SET = 0, FnV = 0
<1>[  526.262684]   EA = 0, S1PTW = 0
<1>[  526.263370]   FSC = 0x05: level 1 translation fault
<1>[  526.267546] Data abort info:
<1>[  526.268047]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
<1>[  526.268688]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[  526.269601]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[  526.270143] user pgtable: 64k pages, 52-bit VAs, pgdp=0000000103f42000
<1>[  526.279321] [00000007f5b55088] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
<0>[  526.284271] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
<4>[  526.285819] Modules linked in: tun sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
<4>[  526.288412] CPU: 0 UID: 0 PID: 5334 Comm: read_all Not tainted 6.13.0 #1
<4>[  526.290169] Hardware name: linux,dummy-virt (DT)
<4>[  526.291025] pstate: a3402009 (NzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
<4>[  526.291607] pc : kfree+0x60/0x350
<4>[  526.292404] lr : show_slab_objects+0x31c/0x438
<4>[  526.292796] sp : ffff8000882efb40
<4>[  526.293761] x29: ffff8000882efb50 x28: 0000000000000000 x27: ffffa0d6d542a8f0
<4>[  526.295127] x26: fff00000c0000b40 x25: ffffa0d6d5379000 x24: 0000000000000001
<4>[  526.296745] x23: ffffa0d6d5379d40 x22: ffffa0d6d4aba898 x21: 6cefa0d6d2dab76c
<4>[  526.297465] x20: ffffa0d6d542a8f0 x19: 00000007f5b55080 x18: ffffffffffffffff
<4>[  526.299121] x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000882ef9e0
<4>[  526.300133] x14: fff00000c0540000 x13: fff00000c0530000 x12: 0000000000000000
<4>[  526.301642] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa0d6d2dab76c
<4>[  526.302368] x8 : fff00000ff060000 x7 : ffff8000882efba0 x6 : ffff8000882efba0
<4>[  526.303575] x5 : 00000000ffffffd8 x4 : fff00000ff060608 x3 : 0000000000000000
<4>[  526.304506] x2 : 0000000000000000 x1 : fff00000ff060000 x0 : fffffc1fc0000000
<4>[  526.305547] Call trace:
<4>[  526.306310]  kfree+0x60/0x350 (P)
<4>[  526.307446]  show_slab_objects+0x31c/0x438
<4>[  526.307948]  total_objects_show+0x1c/0x30
<4>[  526.308514]  slab_attr_show+0x28/0x48
<4>[  526.308812]  sysfs_kf_seq_show+0x9c/0x148
<4>[  526.309901]  kernfs_seq_show+0x34/0x48
<4>[  526.310922]  seq_read_iter+0xe4/0x460
<4>[  526.311704]  kernfs_fop_read_iter+0x148/0x1c0
<4>[  526.312903]  vfs_read+0x280/0x330
<4>[  526.314276]  ksys_read+0x78/0x118
<4>[  526.316078]  __arm64_sys_read+0x24/0x38
<4>[  526.316651]  invoke_syscall.constprop.0+0x58/0xf8
<4>[  526.317315]  do_el0_svc+0x48/0xd8
<4>[  526.317811]  el0_svc+0x40/0x160
<4>[  526.319521]  el0t_64_sync_handler+0x10c/0x138
<4>[  526.320220]  el0t_64_sync+0x198/0x1a0
<0>[  526.321602] Code: b26287e0 d350fe73 f2df83e0 8b131813 (f9400660)
<4>[  526.322715] ---[ end trace 0000000000000000 ]---
<4>[  536.656232] ------------[ cut here ]------------
<4>[  536.656871] Trying to vfree() bad address (00000000a5fbfd52)
<4>[  536.658605] WARNING: CPU: 1 PID: 31 at mm/vmalloc.c:3231 remove_vm_area+0x68/0x90
<4>[  536.660181] Modules linked in: tun sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
<4>[  536.662159] CPU: 1 UID: 0 PID: 31 Comm: kworker/1:1 Tainted: G      D            6.13.0 #1
<4>[  536.663261] Tainted: [D]=DIE
<4>[  536.664160] Hardware name: linux,dummy-virt (DT)
<4>[  536.665493] Workqueue: events delayed_vfree_work
<4>[  536.666020] pstate: 62402009 (nZCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
<4>[  536.667232] pc : remove_vm_area+0x68/0x90
<4>[  536.667917] lr : remove_vm_area+0x68/0x90
<4>[  536.668448] sp : ffff80008092fc90
<4>[  536.668759] x29: ffff80008092fc90 x28: 0000000000000000 x27: 0000000000000000
<4>[  536.670302] x26: 0000000000000000 x25: 0000000000000000 x24: fff00000c02f0205
<4>[  536.671148] x23: fff00000fdaf3180 x22: 0000000000000000 x21: 0000000000000000
<4>[  536.672118] x20: ffffa0d6d542a8f0 x19: ffffa0d6d542a8f0 x18: 0000000000000006
<4>[  536.673098] x17: fff05f2a288b0000 x16: ffff800080020000 x15: ffff80008092f6c0
<4>[  536.673718] x14: ffff80010092f87a x13: ffff80008092f882 x12: 0000000000000000
<4>[  536.674718] x11: fffffffffffe0000 x10: ffffa0d6d53f82b0 x9 : ffffa0d6d2b4c7c4
<4>[  536.675772] x8 : 00000000ffffefff x7 : ffffa0d6d53f82b0 x6 : 80000000fffff000
<4>[  536.676801] x5 : 0000000000000181 x4 : 0000000000000000 x3 : 0000000000000000
<4>[  536.677609] x2 : 0000000000000000 x1 : 0000000000000000 x0 : fff00000c0842600
<4>[  536.679075] Call trace:
<4>[  536.679415]  remove_vm_area+0x68/0x90 (P)
<4>[  536.679795]  vfree+0x44/0x338
<4>[  536.680241]  kvfree+0x2c/0x60
<4>[  536.681397]  vfree+0x134/0x338
<4>[  536.681989]  delayed_vfree_work+0x44/0x60
<4>[  536.682344]  process_one_work+0x158/0x3c0
<4>[  536.683428]  worker_thread+0x2d8/0x3e8
<4>[  536.684162]  kthread+0x120/0x208
<4>[  536.684778]  ret_from_fork+0x10/0x20
<4>[  536.685509] ---[ end trace 0000000000000000 ]---

I'm working on bisecting, but sending this mail out in hopes that we can
figure it out from the logs. The full logs are at: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.13-rc7-1168-g45696205640c/testrun/26824158/suite/log-parser-test/test/bug-bug-bad-rss-counter-state-mmeadba-typemm_anonpages-val/log

-- 
Thanks,
Sasha
