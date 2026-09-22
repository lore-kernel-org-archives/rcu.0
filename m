Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F24E5323
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061008; cv=none; b=Y2LwFRmGTxt+3MzsmOdO5YpGmkfEazBoKCLXkw08NTfe/WgpTM6bVTBSl6C1LVBs91d5v/DPlu4ZsWXc/+LS1g6CDMiWDTvO6fTJnlVayjGsuaud/KraDGPc/dw1r2uphiCHlVQBCYGxUkC1TzWyxGU7IIVfLSU3iptsd5vboUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061008; c=relaxed/simple;
	bh=IT4Omxoh3UL/os4MBcvDO0Y3uwCbEQ/6SyGtTM/wD+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMNHTbMo37jCbigTvnnJIm0whs4+qAZfCSWNYT/161VPYOTdL9TdMD6t47JUz9DrSl1MI42VMX6f+VF/fpCV6wzfAVM1sj0JxkiD4/yEZ0kOnBOeEGMKG1A6lBwP4bduf2zIilNVaOxmWQCtXrB99kJ+/kybCIALA9uOO0Mfcow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp5YMgxX; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp5YMgxX"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc3so2759855a12.3
        for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 00:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061005; x=1790665805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l6nOkseLD4E1uvlk7kwNFkZGEal1mrhs8j7yziX25N0=;
        b=Yp5YMgxX9CYvhky9D6dAN4YK1p9JHW++s5+DVfDoeJueUsfWlEhSkXkcZ/CLrBnXOZ
         rjeZRA8zVPJsidXFHGRy3F8ujH2SMX/+4ty5p2fTITtHMaS2RZGUjampVJpNeImv91Cd
         tBMDhWB0wpJ5Hrq15gi4JetzN3Y9AiuCKMvGdNO6vL4QkMXDolD3fqm1eXzXkJ1pQqEQ
         FjWH2eBytgqlq0w9z1rnmYM9jI0otm5qFJh8TvSp+iR1cWg59jbEwg/9+S2NK43vYaAj
         5lXTo1zQbgFBQQ4GLemYfAo4C1LXj6i4tK1qz5yxtqBqcFjQwSfHsucb/N9eWwQG3QJ2
         ub2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061005; x=1790665805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l6nOkseLD4E1uvlk7kwNFkZGEal1mrhs8j7yziX25N0=;
        b=clXfN2uxcEtqm8/1S5wVSI5g0843hQj7Bgkh+xhCezjl6P9uBabPSLt+r9p9upRO0F
         DS4xwEGmMd9mQeYJuVon5Y9YghUH4IjgwcjOXSYz7ClHlJixcMyxpLvPGj117jwuwrqi
         fnjj0XQSb9QpLPZ5HKEnb9ESCoQVxc93S7ulBDQyLdi7JTIS/lTNGJEsmu/8LipUoywX
         QuH+75b8RaFc86XV6ZTvWTo8Op0dx0R8vOYSL4MSCBARHQme9Xphx0uabgOFSuP/svmp
         d3WZqB4Bmr4bsQg/qyNTHMg1tbckLAk2NJth7d3RyHtbbP6eO3sL8ZGB063M0EW0Kku9
         ahJw==
X-Forwarded-Encrypted: i=1; AKwUvBxcsklbot9FlkQzB1j76ZdePQ6Y5FQ+uFZKjV/bAW2ZOmBMtTsC2J34YNXV8x8mVEVZR4g=@vger.kernel.org
X-Gm-Message-State: AFuF++ljx/2Jea8YAZGmCAR5MA4qAaYbq1eYaGPh+v35qziZcMwpFJYG
	zzOqWPs9gON3kYSVSogy14Nl3jdBZWxLNFvjv48ZiBH7ciCpZdUNxdsw
X-Gm-Gg: AYBFou0EERgJjyfZ6+AnzsjYNOR9bimNK+7HWL/pVQteVe8ScJ7NGUHbNvKkvcONLPp
	FgER9gs59uabC6mdFovWilDQPkRo6WrbvbOfXkTL5VLqaQCx0EKTPx8RtKljcrxBI64oSUaASkW
	FxwNEb8wOQsL6iX/yVOwOKsnppA68ZQRqdF1NqVpki8m8q3mKmsD37/9Worz2EP6BtRGUvXFlaT
	2wQWO/1tfasUo87P25K2xY1qRyzlOcBmK1d59zjG9Q5/XSOC8VetfqDrEBwv5eoo37eWJ1Uhwp3
	lJt4GQdSRnG2Ed9FB3vOV6i+5FE3mf2GmVo9vrc0MHebp6dZdJ7Okf9JRtj5X7CICkncxC+7tnU
	q1OOZoSt+B7Ymx3SEPyCQBSsWfLNvWZSz3Zua5vTMuN3tdofCGuOu5mcQODwqQFbjWrAN0Gv8B4
	ZcMzYXWsPiHcGral+b1+JmA1i6wbSPgJ62v2jErZUo+EO+L3MA9ZbpstddugIboO3XdL+8qLjci
	KY9gJ0fi8pnbqG58w==
X-Received: by 2002:a17:90b:5404:b0:3a0:2900:f577 with SMTP id 98e67ed59e1d1-3a07324277emr253812a91.51.1790061004682;
        Tue, 22 Sep 2026 00:10:04 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a067409854sm3079414a91.7.2026.09.22.00.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:10:04 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	urezki@gmail.com
Cc: akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	include@grrlz.net,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	lianux.mm@gmail.com
Subject: [RFC/WIP PATCH 0/4] hazptr: add shared scan path and lockdep use case
Date: Tue, 22 Sep 2026 15:09:46 +0800
Message-ID: <20260922070950.4173245-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This RFC/WIP extends the current v3 hazptr implementation [1] and
adapts the lockdep use case from Boqun Feng's earlier hazptr series [2]
to the current hazptr API.

[1] https://lore.kernel.org/all/20260919000056.3132131-26-paulmck@kernel.org/
[2] https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gmail.com/

The lockdep conversion replaces the expedited RCU wait in
lockdep_unregister_key() with hazptr_synchronize() for dynamic-key
lookups.

The series also adds a shared-scan kthread for concurrent
hazptr_synchronize() callers, rcuscale support, and an LKMM test
for the acquire-before-scan ordering.

I tested the lockdep path on a 96-CPU ARM64 KVM guest with Boqun's
original mq workload [2]. With a multiqueue virtio-net device
(`-device virtio-net-pci,mq=on,vectors=6`), tc mq add/del x100
completed in 850 ms with hazptr and 860 ms with expedited RCU.
The rmmod workload similarly showed no measurable difference
(1360 ms vs. 1380 ms over 10 runs). There were no crashes or hangs
in these tests.

This is still RFC/WIP. I would appreciate feedback on the shared-scan
design and the lockdep conversion.
 
Kunwu Chan (4):
  hazptr: add shared-scan kthread
  locking/lockdep: use hazptr to wait for dynamic key lookups
  rcuscale: add hazptr scale type
  Documentation/litmus-tests: add hazptr acquire-before-scan test

 .../hazptr/hazptr-acquire-before-scan.litmus  |  49 ++++
 kernel/hazptr.c                               | 274 ++++++++++++++++++
 kernel/locking/lockdep.c                      |  30 +-
 kernel/rcu/rcuscale.c                         |  65 ++++-
 4 files changed, 407 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus

-- 
2.43.0

