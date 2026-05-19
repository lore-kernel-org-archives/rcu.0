Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0573B6C18
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219933; cv=none; b=CGgugPbY4tZ+j7sbCZu59FEXPkMlHYX69YudNqLrbmKq8KIsBWMmkOq8bUpTve65UVd44JBiBa51RjVCKO2s2RB5ubXZjMNUqtLhupOhTHmP5z7+9Sz3RIRCKWfOvrwvkHGFO3aG9X53YYmoubatfwH3ix/kWUAQkb10zg4eNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219933; c=relaxed/simple;
	bh=jofbNNrCF39vcNdNgWy6T1Gh9+EoGuK9YxZyAMEyS4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JopX3ru4KpyLDh5uOTHhRr+SzOwTPpC7rnp5d5rzr6jjSRlWYY8mkPkNiEPBcOKAYqFNLAjqxiEY+AXYTJr7HnkxPOWcRFRuxMbizF9Aw/VXlbjt9jdG9k8Wxva4ln9A65uAcWiOLzwY91nVSTTBBclKknjJ7ULfTASleyOLVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H17agIDQ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H17agIDQ"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39396f873adso60785501fa.3
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219930; x=1779824730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK/hKMv3hTEcKQiSOTXGSh/P8Sd/0hfRCspIyE9/oj8=;
        b=H17agIDQ07Tmn6NxS5ttTrdXdxfih4Q/l+0WMpeity+FLqjoeIpVsVMJxCTfHxAURn
         AgN7Gp201Y8ZcyEyW8r4+zq7MUeuUUmk5frTBCpWFbYk4y2IyJjsN43MFvJVvz0skO3y
         5DUjSoWkk3iNrrcS/HXi2D7aNrQFSbUS4fpWAKIaxba6bz8HVR2pzUnYW9fyZnScQiwc
         8RBTEMTTeAB/np8mlExjvgtyB2AlIwaxwllTb7Yul0GqUXLOUMke46pwjIU5+kFjhw5N
         dW2JHkyd9ezCu7BBVFBkdENGlFnvXKDNRDJIuzo+u2Z+iX0CJe4qCHshRi6PhmGCyyLZ
         c07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219930; x=1779824730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aK/hKMv3hTEcKQiSOTXGSh/P8Sd/0hfRCspIyE9/oj8=;
        b=MdjKyH565bsPjAzvS5SyxjSD9BeR64XctdvYM6Xsz9bJ61vB9XawZ0UOa5KPhsT0Mf
         Ajgb71RTf4mcOkUojycMrja4ndUwkJZG3KHKS/wcF7Y+Gs+5uCj2TfEa0UEzdeleJD2L
         oRKnr2N9+G9XvxhOQ3vq45wosSCS9Yq4qr/cxEtq+Fl8qYL/UR3HOgnVUWGoYEqfvtOj
         iYztBDU9pX/NQ74cShhSASi1cWeLpbYnhaRNogeZUxBpy3Fnr2f+GvYCBwiLDB2GMngK
         ELicN0k8Xaq+0IAyP7e/oaJnQh4Hiptct1pV9bc78NLGUl9jugdrD/DyIN7z7OVm14mW
         xgFg==
X-Gm-Message-State: AOJu0YxYZo94kMBSToEjkVSPtYwGDj8kJn5aYmMAkNCiCSNNRnknZeqU
	skKnVj2MG4a4LmjqOYkQMblnSf1ly78B9TC1bqNNgzmhMLnctZeFr5JZ
X-Gm-Gg: Acq92OGUF371/5vRvOjtTL08J4VetmLBUUV0W9PzDF+Vd3wyLgPX5qgFiqOExXJagd/
	SA19/bQxVkVka/0586croLNRWpZPDLbjxxnQ8Fy0a5eXfAPdUht0e3htYx2hc+bQPVFEjAJ0Y6e
	ClcbtYDyyyTUP3NLapJq2fzmQvXzFYA98IIK4WIFNonnWE5rbg4alZ/Rc/8wzjy16OZ+N/I4wwX
	a5EvsBRObsvkFDWph3gCAx2p60QMae1gn0rV+P4oUjAIbkH0a/GOzmgy8uNBWecypJ2+WiE1/am
	8mgFYkBdxil5YAOXuXg8F5nqyHnv+BfMgh5dwKL5lz8QAnSjPdvexQC/8raN9Lzy0FrbSmvq5yt
	RatyFndHQJj9RpFFY5Ls7hGNZ5UZSNQCmLt1ZorBxmuc96JAzrfeLw/y60Qb390mtlarWKN7UHA
	Vh4n9ewmpoR+oeZ6s/GYizc/WKGg==
X-Received: by 2002:a05:651c:2353:20b0:389:ddc6:a4fe with SMTP id 38308e7fff4ca-39561f520a7mr43597511fa.24.1779219930276;
        Tue, 19 May 2026 12:45:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec3fsm23558761fa.9.2026.05.19.12.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:45:30 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v2 07/11] rcu: Simplify rcu_do_batch() by applying clamp()
Date: Tue, 19 May 2026 21:45:20 +0200
Message-ID: <20260519194524.158515-8-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519194524.158515-1-urezki@gmail.com>
References: <20260519194524.158515-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces a nested ?: sequence with clamp().  This does not
reduce the number of lines of code, but it does simplify the line that
it modifies.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55df6d37145e..e46a5124c3eb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2584,7 +2584,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		const long npj = NSEC_PER_SEC / HZ;
 		long rrn = READ_ONCE(rcu_resched_ns);
 
-		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
+		rrn = clamp(rrn, NSEC_PER_MSEC, NSEC_PER_SEC);
 		tlimit = local_clock() + rrn;
 		jlimit = jiffies + (rrn + npj + 1) / npj;
 		jlimit_check = true;
-- 
2.47.3

