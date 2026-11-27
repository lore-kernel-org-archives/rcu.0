Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795756453;
	b=IeAx9gN2FJpxz+1xf5N5iH6IH4+u2DjseaS/UzV6BQGnKiGcAjYno9SkJzcAgwOhvr2c
	 kn+U5JYTqqF14vQY8Gr3HbeJnY7Zw9RQslJCgcz4oOvzc3XW69MIyYOpkD6kKbR4/Ll16
	 XpXRUf2V6K9Zj5THzrBiscQj1YBcfnRl+kNjyYvmaTvDqErS9dySMjfcnDCqDK4RCJWdc
	 K3BGj1b/KvNvM6UwAOHClFvEwb0VunsGhNW36A0oqSikgV21fhxE+1oYqOlTmKSdky6zk
	 gjeBx/jzJLyOKEN4hzCosF4HYczQVJoqifFMgfA7QJb30BeGOLfTd07B4kpvOQLSjsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795756453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jKPPhHAxB9p6FLiS97eRH3zn7f+B3nbBCbyzaA3weeA=;
	b=QQgd89voShzhTchVYiTHwhacWTISD9VnZO7l8B2IHzOrCkCy70q/le6UY6XI5IHeP1WL
	 RqkN7y9J3mWdGsnmpNvoC6OwyeIGvFnzLeloWi+9LxoKxqF8v6fsbwr12jDquqTLb+KcS
	 3IFKEpDpIOzt1Wn/k1jj6AOxVzxZOqlKFSjIRBhCkQ+MoIHYzBFhVYYUS959aTlqvQvVY
	 JidXEQJ9/0IeCbf0hw9TwJ4MEcbebltwd1VsDydMuRJIBipdRtfKMSY4SL0pHplss1KJF
	 p1cd5vjz/DiRxNPYQbiLHB18RXGLtZf4OL5VoDcoZKGsKZQe7jO7QVPqWfNSlbGTGtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6qGceGi;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C801B606A321
	for <rcu@vger.kernel.org>; Fri, 27 Nov 2026 05:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C801B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6qGceGi
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc147d86bebso4757469a12.0
        for <rcu@vger.kernel.org>; Thu, 26 Nov 2026 21:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795756452; x=1796361252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jKPPhHAxB9p6FLiS97eRH3zn7f+B3nbBCbyzaA3weeA=;
        b=X6qGceGik8K1B+sdebWjo6QYDZdtRBH8f9kD0l2ExGbqj+2BBH8BTehYcNL2j1FUbL
         uKg3xdmwP39gMtBJtww3IPnTCP08QxBtJdIGE94klor0k2fjeeFpeMVrtukhvf1wIPsL
         lByxhb4xM0rKEwneGl0KUBxjTguv++tY4cC1gY7Z8WkUtkv0+3Z8jdufEmNZ+/JMFU+4
         f/wqMaCbHDgdKkKzBIZ01RNLyDG59Z19NZvDXIzkfSvd+7iL7mRB7+k0WRxJQu6Ov0RO
         uoNXMUUi5JxbwmUbrfsX4y75qFE2zs/rK7rr9FqcfSFUffNJ2gZEjyAdTC1l6d3mdIJY
         yuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795756452; x=1796361252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKPPhHAxB9p6FLiS97eRH3zn7f+B3nbBCbyzaA3weeA=;
        b=Ro6fkjm8Lf0c+FZY45t/njsy+8P1S01Z1/PO8MfIzq7ItLcTU84p5gLnxQhdzvquwf
         CJIMRuUC4NQ/AbiItupq1l7XujZQq8Wk9KRGncnfz9Clt/ghcucHVlcqrvf/t7xmm4ls
         kNpi2gg+ZKnuha7fh+XrftYNj5LRUQMdEbpTPs0jaYKrFCOMqg1ZV7YX8axJ6W4qvNrU
         HBwN2zZdIAq5iUrICfLF8m6ZQ+03cofqcMM8VdxCtv7QWy1IfHoWVvy/fzYpeQO6oEOk
         6eH9L3oRUpnxn9USnmxfu18Tafc8DjgUpA56z4EG4ohOvmXRy1wo3i1AwzdkXP9LtHLr
         v+Eg==
X-Forwarded-Encrypted: i=1; AL+hErHlCnIbrIzDxL/vqcusCM4BE5ssePtwInXz0PkGM//DztoI2Y/SF1zexwfD1EJuv0Rp/BM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GtEl6G9C1m7DtcVrdIL1L+CbysqkHHUayTF/3/heHMXNN/w8q
	SL2/S+PTQftGXkUNrYZbsgEhEjzVnAgwXiK/uUy1S05ZsyzFMPvJBvzE
X-Gm-Gg: AZFdTZfhLJ2SDHhsQ7ZrwXx4QUSItErg8er7JD0ih4vLtMGCmYnxA4I+7JRXjDuGTPR
	EGoRMk1dOSJuHwqoeivmUojmRXb8d7fzD09qwLaVHQZNWsijvNeNYIXRysL4a4qTEwMsnx+fTs4
	HKH2d5HOYZ/yTVykK78uHyMvrOdQRm0ecXotCTFPMvrX8d92M/ejrNZ9iXMYrdDC8Bt4c0IZZrv
	OnOhbP2bImMF9tTZWVOjCnv4F5udVBCPsXbAXOLL2rCPqMHRkEUp4RqCkcfsoTg9xY4s9bnDqY2
	geLuUUiuSeEZrYfawH/lcpkiM7xvsU7qs9CFizfUNS62LNLF/4mLo0fLZbsPhPgarBm+jApbab6
	tRVH9FGKNOtWhubYEqvzx7O2q+OJEZci8qwRDwtELtVFhVAb2ZS3HMFXI4wjKTy9rSobhkHmc9L
	mDCaf25b103XuwuZMoXse/YgGwP48W8W8iI7/CztkNE1kxrp2Byvw/nUjvELt7K4bjX5iVj35Pw
	i879pw8xH8qhmUO0EIi4tGPyBT8Bl2nL7N0k9nQPBM0xhGN9l2JtPEpdlHAudVCG7J/wMjaoN51
	SFnf641NwknMkKZZ6S/iXYT+r38zUucWRJ4dXznZ4Hb9T2bVjiHTnS1iOvcspz5QdIAewnw8nTl
	8
X-Received: by 2002:a17:90a:e710:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3b41c96151cmr15079773a91.38.1795756451942;
        Thu, 26 Nov 2026 21:14:11 -0800 (PST)
Received: from localhost.localdomain ([2605:bc80:3010:503:f816:3eff:fe99:6bb3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm26265061a91.9.2026.11.26.21.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:14:11 -0800 (PST)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: jarkko@kernel.org,
	peterhuewe@gmx.de
Cc: lance@osuosl.org,
	rcu@vger.kernel.org,
	Zhouyi Zhou <zhouzhouyi@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org,
	Li Jun <lijun01@kylinos.cn>
Subject: [PATCH v2] tpm: ibmvtpm: Fix unused suspend callback with CONFIG_PM_SLEEP=n
Date: Fri, 27 Nov 2026 05:13:59 +0000
Message-Id: <20261127051359.852628-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Discovered in the Open Source Lab of Oregon State University when running
RCU torture.sh on a ppc64le VM.

With CONFIG_TCG_IBMVTPM=y and CONFIG_PM_SLEEP disabled, SIMPLE_DEV_PM_OPS()
omits the references to the system sleep callbacks. This leaves
tpm_ibmvtpm_suspend() unused and produces the following warning:

  warning: 'tpm_ibmvtpm_suspend' defined but not used [-Wunused-function]

Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() so that the compiler
sees the callback references and can discard the unused PM code when
system sleep is disabled. Preserve tpm_ibmvtpm_resume(), which is also
called directly from tpm_ibmvtpm_send().

Tested on PPC VM of the Open Source Lab
of Oregon State University.

Fixes: fc0ddb3174b0 ("char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm power management")
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Changes in v2:
- Remove the blank line between Fixes: and Signed-off-by:.
- Keep DEFINE_SIMPLE_DEV_PM_OPS() and its arguments on one line.
  Both changes address Jarkko Sakkinen's review comments.

Only a targeted compile check was performed; the full RCU torture test
was not run because it takes too long.

 drivers/char/tpm/tpm_ibmvtpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 51c7e2add3d2..dd577f075c57 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -462,7 +462,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
 	.req_canceled = tpm_ibmvtpm_req_canceled,
 };
 
-static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
 
 /**
  * ibmvtpm_crq_get_next - Get next responded crq
@@ -714,7 +714,7 @@ static struct vio_driver ibmvtpm_driver = {
 	.remove		 = tpm_ibmvtpm_remove,
 	.get_desired_dma = tpm_ibmvtpm_get_desired_dma,
 	.name		 = tpm_ibmvtpm_driver_name,
-	.pm		 = &tpm_ibmvtpm_pm_ops,
+	.pm		 = pm_sleep_ptr(&tpm_ibmvtpm_pm_ops),
 };
 
 /**

base-commit: 5f22fb20497f4983094131f00a734362300d22d2
