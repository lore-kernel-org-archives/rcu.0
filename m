Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5695267B07
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770408576; cv=pass; b=H25Zc1WD8+rnD2WxjbHUGfDrISCxmFFp7lmaor9tRDuDHAvqR+9zw9/j8+AkrpPlN+266KAm+mgqYuSzyAZ/mp0Sn6DGE0YCUOxWccN+JmQTR9vflG2fKd9BYeoXFSqcqYkoFFMZHCLMs6oYk3FW2NMtAK6+rFvvNzGRTAJIRVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770408576; c=relaxed/simple;
	bh=KNkzI7/n94xGAZIGiTH3Axn/jOrvmAt6C/cefa5sLOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TY4ltAMCxKDshhxgDeGf8vSSukRSowZ1mdlNzuwDxJuGP7aHk+jeMc+Ywi8B1Ye/f6c+S1oGyAArekFWt5k4FMYHXBIJvC98UDroMx1PQNBox9Wk1Xg4ja0/COtjyND52NBzvVWVmRxwgz8lHgXDYVH1AgDjK+4e4NhP8xJR8Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpvnvAGb; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpvnvAGb"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-432da746749so1657995f8f.0
        for <rcu@vger.kernel.org>; Fri, 06 Feb 2026 12:09:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770408574; cv=none;
        d=google.com; s=arc-20240605;
        b=VRDou3z+y8wB/JiWnndAQddFpbCdcHWr7Iy10EjcfzmHUlnwR7PbQmm22LLGLGJLrx
         CoM5Mp+8rWfiwGh3Ia0riVDGVcwnhOcCutlXOF9rDwzzMW6hHWId0OfYsRhYaok/znzv
         pX8fT/SqH4areXIdmu8jALIehAy1Vf6gd2m933u7LKc3N7xAus9JX3n/BN4ev7a2Sb6m
         ziZsDDX1ELm1eREGWO0Ot+6atWbC2hPyUhSSX0ZXlc1awimHLuHYRR7DCQodyZEXLkQ2
         yiXDbt7397TGlwYdSeJMcjoNTeLthbXiG9o3X6+VXIUXaMICLKdFWJUAAb7BF9qTm1HW
         XWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNkzI7/n94xGAZIGiTH3Axn/jOrvmAt6C/cefa5sLOQ=;
        fh=qhdPCfxl2Z7G81fgJefrLBWiawZARp2e45AHgqjES2o=;
        b=YxtIBM8lb6Pr/6Hie9YGZofuTmhrfMj+xl7BQpr5XP7RMFwmt08meTMy4LBmhBaDp0
         0in8JylVw5MW7C5T4R94PvI+WU5O8L9INKT2YBpf0gt7LsvWNVi3ZWoauk3/5cx1V8aq
         BYCTZRc+jNPOy7Sbm7IVfrBFajHSpYqZXjGO/cts6/t2nv61OP9FBeZy+hfsOz1PmETG
         YrnpVlbvTyhm0bagSCI4omjeuCEyRgqQ5ABVCofyTpmrKTkPZ58fHlvm3uTqIISZIlfk
         8JXPYoyxmf5hy4g2f0osQcXcfXLYeg6bz3Ebj+yoIVpheFSXw2unvlQavoomVddRMwKl
         HZsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770408574; x=1771013374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNkzI7/n94xGAZIGiTH3Axn/jOrvmAt6C/cefa5sLOQ=;
        b=LpvnvAGbWWDxOeJzNJJOc2f3M238KYr8Xv5nOMfKoD4rHjknmiBMNNyUpFRUNfWV+s
         XXI7vOLWv3zeVnuTe55oQRH8e/3Ct0F1ivgZxCMsa+vnec3L3FQR2iOMNc7thDiVxkZx
         GYLeJ7kTubyacbWX9m3eKwdDFP3GmRSLyunjwwwgqxgbWImqATmkIpiM7Su8xRL0yxYJ
         y5c+hrpuSXjwLOg+NSxUkbFvj3QUiVNPft8fiM/3x/BFmB6UkVjugi93IqGDdRwN2hU7
         C5ZKoJUMP+D6FcvSlMrzKxl02+DNRJbhVVwIRMQWdDAo8dRTMpn4wM/hMH8BAYFdi1np
         t4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770408574; x=1771013374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNkzI7/n94xGAZIGiTH3Axn/jOrvmAt6C/cefa5sLOQ=;
        b=j560huCxGZA7+mkJgFd9IX+i/RVOjm+xsctmbyC85/DbiQ59MLolH/FWM6cW0oM984
         J9NguVvx9S/QAiWJ2WrS3ueizTv2V0LYFufovS1F86XkDMnLmqwumhj2OgSxcYZI5rky
         h6wMdhDqOfFMvdOA4LmEUM4TSbeDq3+g3aMxEt945yaNYa137JTxpak+tHYCqTW2rqDV
         a9B+YIfvV4YCQFGj1YK7mZqzTWGbAaTtZK/6pXPuw1bmwqDX2Mlj1PT1ETkBo+my6LNS
         8GiYst61otgCHPKdaee77f4q3Jlxlz8oLx4cClFpCKglCLMh7owqqoGCw7trEOl8vgH/
         0dqA==
X-Forwarded-Encrypted: i=1; AJvYcCWylk0c5lJLf0JIHKycGSsgfd9l3dsjBjYsn7cxmzMP7NOgcpxhbZvYBX2SpsvguYdE+5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMTsjuJooO9lAlBZa8hU7nnwUhZfJi1lZ6UZenHY9wa7OlnPQA
	oHsAay3KFdjBbB14d6plJzTSCT7FYrpZ1XGQFxsVu680hzByotgQSzygfrfJwmSF6KkX1YaqORX
	4WnjFJkMoSJI+B0mPGOjthjxHAhPcu3k=
X-Gm-Gg: AZuq6aJi4Q21HSt65xkI6pn08WEcTqNZE7RjuryVhuEE58NOqrb9U//F88qI1VAIr7/
	+1GtqpY4zhIizGJqYkeEjVfPsmwgT1/geaOf28fDh7h4f6XS/rEFUupoSNaVHAY/DMB7hStmUKZ
	OHF5bTHHVqd2ILJuFSXcJNW0v/1CsbE8DpHy7hHrafcG0m3hyjFNpYbEwK5hUVY9Arilha3dr0u
	2Yjg3bJjR2vBcDcexWtd5WPNS0uPI9Re4Fcxu2vBvefeoBHqWXmVm8xNwsh6bCjUEIXIIE7kp0i
	JrU8atr1c9WBlMsipt/wV3bhP1qIfnR9fjjvnUFu7QmmAhn7nFTtsyDPs/DPUFPf4sDoQyy/iRy
	YlVJfxBfchQj5Og==
X-Received: by 2002:a5d:5887:0:b0:436:184b:4148 with SMTP id
 ffacd0b85a97d-4362965207dmr5961241f8f.3.1770408574080; Fri, 06 Feb 2026
 12:09:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206093410.160622-1-harry.yoo@oracle.com> <20260206093410.160622-5-harry.yoo@oracle.com>
In-Reply-To: <20260206093410.160622-5-harry.yoo@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Feb 2026 12:09:22 -0800
X-Gm-Features: AZwV_QhYNWBSDD-nTmAfJUx6ToEdVRJ7ZfLrAjTMeLBCvJJlvn_ysojVswF6Q_k
Message-ID: <CAADnVQ+rNYeb5Pu2aHRVc+hYDeAF5t19MVwzXsyn2HkOuLPNLg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] mm/slab: free a bit in enum objexts_flags
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 1:35=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wro=
te:
>
> Since kfree() now supports freeing objects allocated with
> kmalloc_nolock(), free one bit in enum object_flags.
>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

For patches 3 and 4:

Acked-by: Alexei Starovoitov <ast@kernel.org>

I think patches 3 and 4 are ready.
Would be great to land them for this merge window
(if Vlastimil agrees).

Patch 3 is tiny, but the impact is huge and
patch 4 is a very nice cleanup.
If we land it now we can start using kfree_rcu() on bpf side
in the next release cycle. That will help us a lot.
