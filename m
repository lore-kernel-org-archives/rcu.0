Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBB5220F57
	for <rcu@vger.kernel.org>; Wed,  6 Aug 2025 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468338; cv=none; b=nMbdBy3/scljcVmAPpky0dBnvTLU02HxTupZgH40EXcIZIa8FKWNIe0r6TdfWDlxXwEtigLV4disp/c/UEKaBAOMwBYirhQdGwAJs90fDejQbZWE33E0abHQtnckPBTIjfIg8tXajb0Qu51JG8NbJGuOdOFhB7/+3d6ue6ilqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468338; c=relaxed/simple;
	bh=ZIa5n0ySCAvxtZj25PvsitxDDytszLcXX9XdQwpFFD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=lje+I9fOKWf/fSFFJ9gpeTj693Zqexc5VUscXL4PLYxE/SpvTpYMH/edZUv+w7o3HSTLGW1bcUjj5nFKnRBYXd9heBj61FetduT62KK8VT1LLqv9t8H2p6z2MB+AWRdMG8JAjBvQAbn/aOh0HPyE55UtLyNiq+AsuDx3yksdv2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=l05xR5Xp; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l05xR5Xp"
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250806081854epoutp0373cb54d4cf52109274af0e4a32154b9b~ZH6eGLSVW0653906539epoutp03I
	for <rcu@vger.kernel.org>; Wed,  6 Aug 2025 08:18:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250806081854epoutp0373cb54d4cf52109274af0e4a32154b9b~ZH6eGLSVW0653906539epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754468334;
	bh=TP9U+FTa/OPLUCiQ88VrRIyaA5FnNTXTszGwRphWeRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l05xR5Xp1gy1BbDUV+quRdPBkYR0lLsMliFmRb6mAtPDenKzvham0CTRSG5J/VOS6
	 1GyngqHOgmvu0rntdRJYWfoxIWfSDdV83pA3xMIiuyaZMWj0InD+wkyU38Kp58tew9
	 hqP112/W3mmvKVG2nqiAVT/bVt91vvC87RnaDl2w=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250806081853epcas2p162cf960f7815b74e4dd14d2025e37367~ZH6dYkI6A2204222042epcas2p1e;
	Wed,  6 Aug 2025 08:18:53 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.36.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bxjqd0gLCz3hhT9; Wed,  6 Aug
	2025 08:18:53 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250806081852epcas2p31662b77b33cb6ade6f7a5e85d53d6865~ZH6ce9IHs2605426054epcas2p3h;
	Wed,  6 Aug 2025 08:18:52 +0000 (GMT)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250806081852epsmtip2cf9190be67158c0248f7c69a11eef8bb~ZH6cbiB2B0717007170epsmtip2o;
	Wed,  6 Aug 2025 08:18:52 +0000 (GMT)
Date: Wed, 6 Aug 2025 17:24:02 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, syzbot
	<syzbot+ae5b16688c0c675b1a1f@syzkaller.appspotmail.com>,
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com, youngmin.nam@samsung.com,
	joonki.min@samsung.com, jkkkkk.choi@samsung.com, d7271.choe@samsung.com
Subject: Re: [syzbot] [rcu?] WARNING in srcu_invoke_callbacks (2)
Message-ID: <aJMRIm7+KlCqT5hB@perf>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2c367857-e1a5-4235-94f4-724441e94968@nvidia.com>
X-CMS-MailID: 20250806081852epcas2p31662b77b33cb6ade6f7a5e85d53d6865
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----pvtuYNBH3nxDMAsWpkvaC3wqZGu-8cOxHg_F0zl5WTIHs9AT=_112ad9_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250806081852epcas2p31662b77b33cb6ade6f7a5e85d53d6865
References: <67b4c7af.050a0220.14d86d.000a.GAE@google.com>
	<20250219132538.GA468969@joelnvbox>
	<27f4ffbe-2342-484d-9924-716a799b265f@paulmck-laptop>
	<2c367857-e1a5-4235-94f4-724441e94968@nvidia.com>
	<CGME20250806081852epcas2p31662b77b33cb6ade6f7a5e85d53d6865@epcas2p3.samsung.com>

------pvtuYNBH3nxDMAsWpkvaC3wqZGu-8cOxHg_F0zl5WTIHs9AT=_112ad9_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Wed, Feb 19, 2025 at 10:09:06AM -0500, Joel Fernandes wrote:
> 
> 
> On 2/19/2025 8:58 AM, Paul E. McKenney wrote:
> > On Wed, Feb 19, 2025 at 08:25:38AM -0500, Joel Fernandes wrote:
> >> On Tue, Feb 18, 2025 at 09:47:27AM -0800, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    a64dcfb451e2 Linux 6.14-rc2
> >>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=12398f18580000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c9c47badcd079906
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=ae5b16688c0c675b1a1f
> >>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >>> userspace arch: arm64
> >>>
> >>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>
> >>> Downloadable assets:
> >>> disk image: https://storage.googleapis.com/syzbot-assets/c0a862fcec77/disk-a64dcfb4.raw.xz
> >>> vmlinux: https://storage.googleapis.com/syzbot-assets/f03793fc001b/vmlinux-a64dcfb4.xz
> >>> kernel image: https://storage.googleapis.com/syzbot-assets/ae71c33eae14/Image-a64dcfb4.gz.xz
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>> Reported-by: syzbot+ae5b16688c0c675b1a1f@syzkaller.appspotmail.com
> >>>
> >>> ------------[ cut here ]------------
> >>> WARNING: CPU: 0 PID: 6430 at kernel/rcu/srcutree.c:1798 srcu_invoke_callbacks+0x368/0x3d8
> >>
> >> This is weird, happens to be WARN_ON_ONCE(ready_cbs.len); in
> >> srcu_invoke_callbacks().
> > 
> > Thank you for tracking that down!
> 
> Sure!
> 
> >> Perhaps, stack corruption or the SRCU cblist's ->seglen got corrupted?
> > 
> > That has been the usual cause.  And a double call_srcu() is a common
> > cause of ->cblist corruption.  We have CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> > set up for SRCU as well as for RCU, it appears, so perhaps retry with
> > that should this ever become reproducible?
> Makes sense, will keep an eye out for it!
> 
> thanks,
> 
>  - Joel
> 
Hello all,

syzbot reports that this issue is still occurring on recent kernels,
for example 6.16 (see https://syzkaller.appspot.com/bug?extid=ae5b16688c0c675b1a1f).

And the "CONFIG_DEBUG_OBJECTS_RCU_HEAD=y" has been set as well.
(see https://syzkaller.appspot.com/text?tag=KernelConfig&x=dcbf08d90aa89bca)

But there were no logs related with double call_srcu().
(see https://syzkaller.appspot.com/text?tag=CrashLog&x=13e40434580000)

Unfortunately we don’t yet have a simple reproducer to reliably trigger the warning.

Could you please advise whether a patch for this has already landed in mainline,
or suggest any additional methods we could use to further validate and test it?

Thanks.
Youngmin

------pvtuYNBH3nxDMAsWpkvaC3wqZGu-8cOxHg_F0zl5WTIHs9AT=_112ad9_
Content-Type: text/plain; charset="utf-8"


------pvtuYNBH3nxDMAsWpkvaC3wqZGu-8cOxHg_F0zl5WTIHs9AT=_112ad9_--
