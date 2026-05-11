Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DEE46AF3F
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522096; cv=none; b=nmRVNvrKsVd/1ozgjQlvQ/H+/eBD7rg4cz29hOldG1max+HxcvjTgxTbhD1T5bdnYTTl9Nwm5RU//wFPvfzvvJ78bL8jtcPWewNhkSlgf3x2Ozl0iaKIUjmy9k2wuFOuQv891W8G4lppcXFILoolDCn78GZVUHe703l/+6tSe/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522096; c=relaxed/simple;
	bh=AMef3pkMscCEIVOua4C09Swew/rkArkcZrElIxGazHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4/8TQXVA1/lGD/H18X6BFP/22I6AMEw0wue2LVrSOqHE7DVYeylRNLgxMSRru8oplaxo+LeaLT8NGGVeXK2LnkKebc8qBrVO5kHtU/0S97GP0QNhdjtLWOsfn1/hxbEP2m2Xlum56BP1TN+mlgRV7giaasn1rPDw0lhQEsuY9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIwYHwaF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIwYHwaF"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-393a44854d2so36399301fa.3
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522093; x=1779126893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfW3Hcm6nkWUn/ECmWMffp8Hi+yYbyAl2pZxyKPEktU=;
        b=PIwYHwaFQv4ND9twDQ/vLD/R1WsrgvyxrpgWMzKzfiafhNssOaKepcmkS4tek3CGxe
         wDIWAJ9KASLslpyT8AjQwb/UavKKB7s7h15r6+neiXEIG/Jnuoxwqsro66bHFQSnIoad
         YSFOxBo6EUB+nSA4P146MN8eonpSpAt0b9CENaSDed1+DeNvV+7/10Z9TNGDxsc8mfAt
         +Xud/7zoUGY2F7b9nKWB9ncc90Thp3wz09Zis/IftykytCA6yvNS//n3akCtFaRVNBHd
         ArG+IqIHUprS+oze9NQ0XAMQGBWxPXascbUueaTyUf+JyEwKK+Z4LSpdGRGw2m8KMp4+
         8x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522093; x=1779126893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XfW3Hcm6nkWUn/ECmWMffp8Hi+yYbyAl2pZxyKPEktU=;
        b=R3W0GydMtap7xZai4LrfMGiEPc3BwDENZXcOyfkyqB3AqT+qfibSxBmei1BjjMfFjm
         HxHdDrqitK/sJkEP9CxABsg9YlWfvTRmBVTjpxVL9XDkCMV1VrifySNGtk1I4MHLBkoc
         yYfD0djUMgbrm2iQTUka9OJySXdLylKddKU1L1IUth1vGBDfZSx+ILaEYCGXomZ3e4FI
         XJHct+52HJcSmiznXCvCRT58X/mBoLyDPI05VEl0YK1GRj/688HDIaEPMVbaZJKsp55a
         vezhr2OenwC1ztVFOCD4PYvown4qvkmQIHJdJ69kurHOlp2FVbO5E31TVfJuFpA+BB6F
         YgGA==
X-Gm-Message-State: AOJu0YyeZLvouy1pCDXjYq4EsdHSWe8ILRGfiTcFbrNgrft+DwzVjVVp
	fwgXKzCkD4pZIQPUnOEfGHEyeSZEY4R39qvJRSUbCiikTGrjqoS1P3OS
X-Gm-Gg: Acq92OH2RLkghIHimLWN6KwFcGwSCQSGgV33u7H9uOpv2rJeEQ4kHCzXo9gyY9uYAVJ
	FnArkz7sfkavszgvAWkSi87av5qN8CEq+9wXtczUChpkxSy2KpbvkYZRXPB9EhgTOLrtyxoSazL
	t1w29en2l3cChPAYdLj6HuRIzBQpOZawNQCpiFiQA0az2r4H/+c5/2OrCTDn2ZDSBTMbY6At0Wr
	XaAgqjkhqL8Dy2Ogo/UhBKDwT2V4C8oDbO7IJ1uurkWaTotyPWvgDFGNB0OfXg+WAKhsE2LnbWI
	QFNZS9UNcu9WqLRvOMeqsA0qlZ2dDrKSueM6m2A9Ui3OERoY0j1opB8ZChIImI2vPpxLwofL2yB
	Sa1k7WgIbCEr3Echq1h2/RqqhkMuHh7ZZZrxVNMEuhbF0vG4lZopafst6yznHwVEaVdN3xk/Xh0
	+WEuHHp6Eroqv2ALos0fi2gRPDIA==
X-Received: by 2002:a2e:bc14:0:b0:393:a4f5:3e0f with SMTP id 38308e7fff4ca-39407ff0857mr37459531fa.2.1778522093253;
        Mon, 11 May 2026 10:54:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f614a5f4sm28968891fa.33.2026.05.11.10.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:54:52 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v1 04/12] torture: Allow "norm" abbreviation for "normal"
Date: Mon, 11 May 2026 19:54:40 +0200
Message-ID: <20260511175448.153326-5-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511175448.153326-1-urezki@gmail.com>
References: <20260511175448.153326-1-urezki@gmail.com>
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

