Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D443B4EA3
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219932; cv=none; b=qFBSwSmAXX0kSf1KEf+oglCQZiCGWhgLeWko3cjKTkQeV5O1gn5roBGx56HFEVLTNtEUm/gK8NcXT3JS/zwomGS71VfNyfWsFi0caXKXBWRTqm/x3/VfPN7X+qPA36ywX3X106K44FV2YqwZiuY+bk2XyKvmUhu+zcHLJWc3tG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219932; c=relaxed/simple;
	bh=AMef3pkMscCEIVOua4C09Swew/rkArkcZrElIxGazHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RY9UPrIFujDRjK2lOiV+eCIxi+e/17/C3KXdK6Elb29dTLPNQzztF7pHlOYaRKsstVlEeM45shMzRR4o8QYCHcUt4srO15YDfrMiVLbyV72ALZiq649biElPQODsjuEBO8H1nkBvqqsqQXH33QZv3MGLBqigZQ6pslnvOH/jVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWHDersV; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWHDersV"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-393da8f389bso39237291fa.1
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219929; x=1779824729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfW3Hcm6nkWUn/ECmWMffp8Hi+yYbyAl2pZxyKPEktU=;
        b=oWHDersVRari1kGQKDVzLjvAu6ieWFedprS5Bb6lVnhtFhIy4P8cAimpMH9Ewadb7l
         1+WbpTt8wEzKN/QSheMb/Br2VKBTy5GRwGGgQxnH3Dm/Ed1iZBJGKfBoOfRKMhCps4Xm
         MfY2xCtTewzxN+A2cAu6hyKnWfUMee3e2CWHpY8HhE5dPcuuMNgpViGdpjrghm+fS+yL
         Ic1TLyQP3OPXNpOGdzlgOzdi03MEw+zFhOvAGi9uYVHzNXKYyJBV2ExJnWG7C79+BFAc
         nRdyftVNfc1J31vJ0FVCth6MynF838JU5tCrKAL00t86qdbOmZZulbMOV4wSLgyFHeTE
         kACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219929; x=1779824729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XfW3Hcm6nkWUn/ECmWMffp8Hi+yYbyAl2pZxyKPEktU=;
        b=lnv08/aBD4e+eIzS+FFaJZp57Y+ozl3lzCGEBpjOGQt52j3MXA5uuFWzcSEEhZZIUv
         DbXOaJsMU696ILrwFVf186CAWV9IZkTifSiRKEQTIHN3txLxLv0oM8QzI2CXpzgXT6yN
         OVV3fueyiJzlQb+EQ+ORqdJgC+2N1UYrVvJVm/nqsJdyxhm9aUUI2N7u/mALD+BKDIMS
         FyPoWSL0dr56IOTIe41sdWT+bnce8MPGSXNQg1FEZIsODv+YgWK1vkoySGiRpYKiZxSB
         w7e4qnuf5V6x1F/XzZSiZBrshXUJ7Uec59PK2vc80LDoBXSIkypA6ZrE66jQdS0Z47os
         l5vg==
X-Gm-Message-State: AOJu0YyKn4xvd67tXq9ZwUSsHt0hgbciPZ5XLd4+wQ9siKK7v/kYZZfo
	+oCabw0QSYjI2JyR+SxImCi92Y5p8P5oerrDXsUp1a2gXJijVcXrTmTZ
X-Gm-Gg: Acq92OER49cpYHNSqa62ByHPC14nl4uHwHInZS6wdRZX0C2w2Dp0ywzxctyzHCrkgmY
	k7T3/msA3pJjGrwQRSg537FOfzgI1se4jGRknyxpPPt3ybZjIF4ecSeRuWNVrex3moe7mrNu6aQ
	WOI7KJI5dMDdRjcGTWxILejMO2q+GD+M5SM8jpNq1GqF1cX18SqqtJa2awxIdgJTL84wOnxo8yQ
	Sa+Nr885m3H8NWODRgR1OWsJlpR25hoeSvY4fr/Rc21F6cItWtzWj9fNU7wdLEZCeJm4Tap6AZI
	HIq66oJCdI9n/84cwaSEW5/yy2RsXwcfwtMmlwnyINgekv7aEZQhqHVfR2u0oS0PE8arA1mzMeB
	IgjP3H4PU5w98SPONJqV25LGGabxVRETJAuYoCq3lLihfzcvx/d4IhWv2223zPVPbZex7BMeilw
	0SJa4tWJua2k/e9HjOtDhd5liy6Q==
X-Received: by 2002:a2e:a5c1:0:b0:394:4e7:9805 with SMTP id 38308e7fff4ca-39561da4af2mr65127131fa.19.1779219928668;
        Tue, 19 May 2026 12:45:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec3fsm23558761fa.9.2026.05.19.12.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:45:28 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v2 04/11] torture: Allow "norm" abbreviation for "normal"
Date: Tue, 19 May 2026 21:45:17 +0200
Message-ID: <20260519194524.158515-5-urezki@gmail.com>
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

This adds "--do-norm", --do-no-norm", and "--no-norm" synonyms for the
"--do-normal" group of torture.sh command-line arguments.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index a33ba109ef0b..f0083891ee81 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -184,7 +184,7 @@ do
 		do_clocksourcewd=no
 		do_srcu_lockdep=no
 		;;
-	--do-normal|--do-no-normal|--no-normal)
+	--do-normal|--do-norm|--do-no-normal|--do-no-norm|--no-normal|--no-norm)
 		do_normal=`doyesno "$1" --do-normal`
 		explicit_normal=yes
 		;;
-- 
2.47.3

