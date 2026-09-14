Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE147605C
	for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394018; cv=none; b=DEcAZpcnzA0KyhjYPZMvEKPardfuVebizIaRmbB7EbxKDcODDxg5BPJZdtBAjN32JLYsTHgQlrnqwOhcMuQH7C4fh0XWk6hV98u5xRdwJ8JBnYiT+eHzg436BXLWCq2eubbOLyUDdut/0XAy1aUiUcLWjPDyEpbi272CpZ014vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394018; c=relaxed/simple;
	bh=BEDapZrL6/hvvO2kXpOejmvG4ExYC83wI5Wnd+3+Nx4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mbQqld5gGgpOxJcjgEgne98Els6ntzRApuBf7FJBjzdP0mjqgHJFUXKZNYJMZBXRrtMzzvenqti5EodiFmE5zD4zm8n7jRvKksDb1pRHE+UHC+Y8pWn25hgtvCaporLL8P+1aeiBX60bOxV4ygHbogi4/pnCQGlEjJ52fG7di44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X9VYh8mG; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X9VYh8mG"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a318299b93so15121511fa.0
        for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789394015; x=1789998815; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dBgWHSwhYz2Q4YLyQIKrQwL4mQeJ8ts96wvrrquXsvI=;
        b=X9VYh8mG+g9Y/RJ4/6w9KieHLcPziaHyhafmXhleClFZq7w9lUJ2r2Zd8TwwxOXxWD
         g04FTp4sssxf+XhAoGPHZ5VwSAzCdcvmV7PKA0EmGVQJKxO6nztD+ejViepnK4+h3pud
         hYwoeq1eEILuDndIKOz80LonoQPkGuq+U8ipA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789394015; x=1789998815;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dBgWHSwhYz2Q4YLyQIKrQwL4mQeJ8ts96wvrrquXsvI=;
        b=Z4jYqCtSOW1HXp+238f/az2G2OfhOC5i4hioADsWrpkVVBorVBTdSsqewpRKcyRp57
         hHf4msaylASVCKkizovzcMB/50TJ9tP3sDOsdhLoa7V1guvdt9p3eRAV9lXmrjxYXLC5
         GysQea0YCYok+3i5E5yXS/wkD2KpvZmP4ernVrCibsGff3MV+m1Bw9EplziqK4MbKZlw
         pRwOFrCl3Q0uheGTGCROpO0WmFSf91RGE3k+LqyboS0cSIlI7Op1G/FkDNU3oummDgho
         4aLSCt1nD02eJC0fi7WFepCEdXCsvfTxSXmeF7Y5Cw+nn/hnWh85XVda8/njiBPNE7HA
         Hpog==
X-Forwarded-Encrypted: i=1; AKwUvBwMWpX2TVefz5j+FNZqrLNxMPu3ICF7R1KTi+1bftBJbM2aeORuCpFpJRppft7w17UmCfw=@vger.kernel.org
X-Gm-Message-State: AFuF++kT7KUqOUBxYneSz5MfImmUzfG2AG67t4iKPwQOfv1HSZFkkoQE
	2E6lpkp84HZMgEUy4HW04I5zUTYShdvLSRo4gQG7inufeU9kmU8zcZrtXGlfTNwC4A==
X-Gm-Gg: AYBFou25Olq6oK7KhnK9Bo9Q6RnMgUwojBwRf0/HdR/zp2SJII5AXMvRIjSjfjV+qIJ
	O8DnYY0OvWfxiWFa4Jc50rIFfRRtn/N8eszs2Ppgw7JBEUNziUJ89zlI554WA24zm9BEL+HlWSP
	VP7ISzLEzoSKdbeTkiWH4kNqknTKiOpT22Zk+38WJD/V5B4wDN5ZJ+OPEPyse7Z95E3TqM77Wcj
	vrc3zdu0/sp1YyeiQST9NxY0vM5DZOxRcMUqor5+QzG2IoDuJ4zwbioKi7Q61rTKbwTwK73FzpK
	dMndLJsduMnq+IN2RDdN1t5xDZoAclHgU8bv9emXYzWVk8oMf6Zp5xDGqXBYVLhQztGY5wR1B0Y
	P5ivWPA+eKiRzJKOJJJfrF2UIrxx+mEaEMxbMnlKR1QJbdh+k93f+zlyt9qZjwnWxMvTpjt4S+v
	pSHku1H6A6Jql4IHbcBptwrO65zVsd8WFlvxiybExTS50/JjRmUu0DfzJsxSp9S7LEX14xM+1FS
	NZgd5q7YVIUv+XnXEh5aKGocl3tvGe/vdFC6yDYJznM6SJm5Q==
X-Received: by 2002:a05:651c:19a9:b0:3a3:115d:daf0 with SMTP id 38308e7fff4ca-3a5c885b96bmr4384971fa.6.1789394014811;
        Mon, 14 Sep 2026 06:53:34 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a3304b38sm29433921fa.13.2026.09.14.06.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:53:34 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/2] Fix warnings with recent smatch
Date: Mon, 14 Sep 2026 13:53:30 +0000
Message-Id: <20260914-unqual-v2-0-60a1407a0cd4@chromium.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFr8p2oC/2XMQQ6DIBCF4auYWZcGCFbtqvdoXKgMMkkVC4W0M
 dy91G2X/8vLt0NATxjgWu3gMVEgt5aQpwomO6wzMtKlQXJ54a2sWVyfcXgwWesOsVFGCw7lvHk
 09D6ge1/aUng5/zncJH7rH5EE46zhUpmxFaMy3W2y3i0Ul7PzM/Q55y9C65KunwAAAA==
X-Change-ID: 20260825-unqual-25d9ee74fd10
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Chris Li <sparse@chrisli.org>, Dan Carpenter <error27@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, rcu@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

Recent versions of smatch preserve the address space qualifiers while
running typeof() [1]. This has triggered tens of new sparse warnings in
media-ci.

This series takes care of them following Dan's suggestion [2].

[1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f
[2] https://lore.kernel.org/all/CANiDSCuizbMt77XfrzGPMa3Biai5TF1vcs+C5qdhYoLrP=9b3g@mail.gmail.com/

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Add TYPEOF_NO_ADDRESS_SPACE() in compiler.h
- x86: improve changelog
- Link to v1: https://lore.kernel.org/r/20260825-unqual-v1-0-7024fb81b4f9@chromium.org

---
Ricardo Ribalda (2):
      rcu: Drop the address space qualifier from the dereference macros
      x86/uaccess: Drop the address space qualifier from put_user()

 arch/x86/include/asm/uaccess.h |  4 ++--
 include/linux/compiler.h       | 17 +++++++++++++++++
 include/linux/rcupdate.h       | 10 +++++-----
 3 files changed, 24 insertions(+), 7 deletions(-)
---
base-commit: 704340f1cd0dcef829eb62f5b48ae95a2ce17bdf
change-id: 20260825-unqual-25d9ee74fd10

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

