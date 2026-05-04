Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3119D07E
	for <rcu@vger.kernel.org>; Mon,  4 May 2026 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911362; cv=none; b=dPhwRcOpI+82rjoXXckUhc0JUyie+mg9iBXFuQ1h0uqt7oSlnW7S8qntAt426vFLCRgMhrXafYl+97mcm3x8+OpdA3/Z09qvRDpzzfwSA+cedrjOGHHg5NZbw1M8jBwZVVf15hieZlMjtFvUMQzhbEzAvAHdhHi02pg/gkL23UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911362; c=relaxed/simple;
	bh=sTDR12sjqTwMm+r4fFdhIkquUwcGi7MUb8j8uCRfvQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6Nk7rUJ/kt2RA6ZPENuWUm9ooOU2l/4fcVtbZEKlH2ApDzP/VzGk/+jgMjPbcNfxvDg/NvBhFQK+L2V3JAE9BT7spwfoy2KdsND2YwQoyOD22rPZjnOgEsMdbmb+oKE0OM85LfQvibS6xxHeP0o3aA27IQqcY+zfHtzDJQ/qpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkROKRDd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkROKRDd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad9f316d68so16860235ad.2
        for <rcu@vger.kernel.org>; Mon, 04 May 2026 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911361; x=1778516161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSUUEhTxPVnTNICfoGoDgRMvs6IfWcbouR7fQZ1ACRQ=;
        b=IkROKRDd6JE8wJ6GZvRPJ2R24fwIhwhFN3ESPuGvJWRIhlXF+jMqm1Uzkf2mKGRWGS
         WVEAfbcA66aqkVTjWpywNdA13Mne4Z3ocOsLkr/c9JtI/ao8Z3uMC4+u2KfkVMPXgu5p
         c7OWFtm02Jc9gwBj0PO4n8sTGhUuF1q+s+ltM82U3O97mUPMxq9FHDGCcysKYA7hBNSS
         lE22zbeMbeBfeXkNYW5QJJo28TdNAWEdjudahNalhwlLjY89YcXE97WrlEXkGmIO0FCY
         kKQbmRstiUObE3mN6EfZAuDHmrAWjUrAd5YhVz3N+P0ZF1wwVVQc9ikOZ3KMk58LbQBV
         jf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911361; x=1778516161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSUUEhTxPVnTNICfoGoDgRMvs6IfWcbouR7fQZ1ACRQ=;
        b=ZOGZuP7usQ/q2Qrf/wShAjGpfasiT2fhemf3kUOTEtoBSp6cORUH7OfKUioNfIAwO8
         xt2RPqKJuxTZVcO0C6KPF1zkTlhG/2Lgc9sHlxlSiT5j003jz7quMqyL70dkCWH/0fq+
         rYDKbXRW0XxgxUcvMtwzoDr5xQL4H6BEPOcfZxmKgl5rnP2P5ZXoGFdJVuh/bTbQmNX3
         E76QoAro95+hIC41yPh6ql4A70wg8IrkPbc03qUzXwqIFMmjwflBLpGNmo5ONq98ZD7E
         YBh3JjYhYpQOzUCWCA0lfcCTGcUGU9mWPod8DvZhal7mf4TT9ffwEEv16MBuYdgOVhNJ
         JREA==
X-Forwarded-Encrypted: i=1; AFNElJ9Zn2Z6SZImmu1uuGWsBF/7oo3wWUzUgxuypZ7H/Ekrp8DFZNDwXq6oI4IO7fI/9uOF6v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xDicbtNa+dfQz7op0+gav80rglXqCJHhGv+fKtlgyPWfHbnf
	DFBlxx8bgCG5jp/zHs5fSdvx20qv+1mrgjh3cJnk7MuMXevqdlbwPohh
X-Gm-Gg: AeBDiestIgx5QKpcDal3PAf9oq/Jdpas0eGoahkBJvG5/jpVxBmR3SbTPhUz08nyj5U
	uqlRNlCdhNqng3+Auhy6G9ifcBL6xWnMLZHL8z9pnLekbyrDT+5LSiWtCBI+vTbOMoDxWQQLiVh
	dw+rS66BrYS/B6g4wxWFsqOf8iE+w4sS0XGruLRbHfmWiy0BfOsurrwpaT1nzD1t03r2T7QlKMY
	itlsEhOSBueV9dDdWjWMMJzIao/NcV+4JJu4A5M2Z792oG+hdwECgx32jTAic7gRLjuFJzO6Dla
	MptmzFVCJ9dGQUI1YdikzXuIahOcQGrzBCcXy4HEqht/igvGR1ncLJ4UvmhB63m38TYBaZpSvM2
	hGWri4jt/mE+vqWI2nhSu7WjFM6Ga2XjEs/SuxvLQzx7YmOM81+G3XtlZVVC5xf0+U+vQ2njUch
	dnoSxwokV4eaVsqzFascNzTyZHNuJDcfumln94E5wHnWdy6NGdZUfIAyQLBBAYyA==
X-Received: by 2002:a17:903:ac8:b0:2b0:59c4:e9dc with SMTP id d9443c01a7336-2b9f25e22bamr102593345ad.22.1777911360727;
        Mon, 04 May 2026 09:16:00 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d123:1fb:b1d3:aa01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba4ccf6a1esm2385745ad.81.2026.05.04.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:16:00 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2 1/2] sched_ext: Normalize exit dump header to "on CPU N"
Date: Tue,  5 May 2026 00:08:19 +0800
Message-ID: <20260504161543.674488-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260504161543.674488-1-yphbchou0911@gmail.com>
References: <20260504161543.674488-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unify to uppercase to match the UEI output.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 45a2668284bc..48c65ac8e230 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6486,7 +6486,7 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 		dump_line(&s, "Debug dump triggered by %s", ei->reason);
 	} else {
 		if (ei->exit_cpu >= 0)
-			dump_line(&s, "%s[%d] triggered exit kind %d on cpu %d:",
+			dump_line(&s, "%s[%d] triggered exit kind %d on CPU %d:",
 				  current->comm, current->pid, ei->kind,
 				  ei->exit_cpu);
 		else
-- 
2.48.1

