Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0BC423784
	for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378505; cv=none; b=AkOnl/+Csa2xntpt/zzpIzMKoHJmOD4UiDxXaqyytJwwGX8TTeN0nhKvEW+ZGL2TB71ylvyB6PUFuUIp/FEDGUQnTXvcXrKYtJyC3FfL1VsjiEjcS+oyQeL48CzVogS/wY39iUZKmQ+pvVdXAb2z4dXzm+0gubloTbdElLR2e1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378505; c=relaxed/simple;
	bh=RWixKcQI2wmaygQZobVDeYA2rMusdPg2Sj3o1m1LYFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9+C6UURi201xCLoc2xRXo8IaeZVu4qr4J+jnLGsMy4DOibkcMwy/6MNzvUYeRY4u7sqxL8WnSOy7UPgerxpCZWAMMzbDdqSwXjiV0dwR+vUUBqIyEZxpHpw6UGPoi6E8fjpkhQFp/rzbxNuxzMsu75ly3JsTRzzQBp1Ipqttkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YED872fg; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YED872fg"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfb6so763979a12.3
        for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789378504; x=1789983304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o6IuVmpr5xM+RRdI6lEpXivXGb0nbPt12Ew5SJP1A+U=;
        b=YED872fg8vrTMmOVUyr4JuDCYViET+rLqWFovHJMHcqBEooxh5tMdIPXEZi2lw6hj5
         vBDVfKpnvQUOjKR/TFuPj8H/l3e/tmeHrqRJBRBNgOEZ/7c9fQaB/9X4/XjPzdVqXRUv
         uR0veKVwC8EQQ8bcZ9T16rIr018vxQjOvyJn5GbgnMP/9T50x1Y79U1Je6I1OhcphyOf
         IbgM/9UuEsOHgKy35MxVvOuThodPQPlF1x6LGb26mLp55R/cNmFNoSdAndTejZVlZu5O
         YDPMNgFBVB2md8IO8Sdsad2lrfTFZPjtN736wGtj/dykzsEtn+jk/bCghnvfGI+LUKZQ
         hsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789378504; x=1789983304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o6IuVmpr5xM+RRdI6lEpXivXGb0nbPt12Ew5SJP1A+U=;
        b=A9Y3nNH9MmDKI5T8q/iSP2jSNN6jOlT1tYsPDwIkxd/o4BwMNroD0UDIup7bg21RH3
         6DNGZ0r7qFGMwQ/thfZJedNhzt4CmlV4Ta3D2NJbWVcQiQml2mrRp6JHpC4PDFfN+kCr
         p38082doKvY1CSBHqQpRWDDMKFne2vjUiQyCLBEsfoxX0Z90o3YfimF93soN7mZYy5sl
         1HEIvSE9nW9ooLjHQZSNOGPbs1gB8Gi+Zc6jhaNhgT4pU9N40CwKKl5/yy9E0cpJftpT
         KY8NXVb5lGfnZ7m6rN9Z7cQNcLJdLCySiZLig/XRfhfU4Y7cwy9Hy3JXuG9yePz+GaP7
         Bq4w==
X-Forwarded-Encrypted: i=1; AKwUvBzw95QY/1S+IIWSHIcuklrDjiVUEft060SjTJQI+JNXVipSw1d7AhpAtAkO0ffsrY5k5lE=@vger.kernel.org
X-Gm-Message-State: AFuF++kgE066bkc72YFjAjo1U+NPDSenJ9rxLpNfV8JmQzoDjzrHh8Qy
	mgcmQG3lEFZcaomtQVcyEGKJmXAS8VeSLDcSKaT8HRGVqwQ/4qd4Y+7T
X-Gm-Gg: AYBFou1mtom9RzcVfXYFLX+rVEKW69Qmu20UDA8CKU83gf/+TR5opu1XUY+CFm0OPqM
	mvvsQqJyd8Km8IgqmJW02L6tMgHrelMQM6iPeOrtINZ5aquOix4gbyu66+SLkyYx8Ufqy1KZ3hS
	L+3xtNKKdFQcd2CwAX1OI0Crb19Jx8QHZ2wcce1Gvulbbl62zxvZiEHBn6Mh1OGgRagSzC++bm9
	3qfQNYka0XBlfxmk+FLJBH0tYFOfyFIjGbOGXFMlbKa+33RcH4jNFJJk+xB09vx9nQoEsxie16O
	0ivunoWUqzChWILpgU0bppe6yDFt+rfedFJFKWSJS7UOwxHLHzbxz0XxvAoIBUcs62F+NAS8Wtk
	RA0WxwhSyOpVjQ6mP4eRybeUdhBERmE7jl7F5mysWyG/rhSbsUsrzVSeN9bqZvQzctqbeYGNNa5
	/Mxn92/zFEWwi2bQGXIcPKutTLOd+eJCw+DjjMvPGux57xa7KCpKBSi7RrQXVWvp5Mwg10wnLpo
	iUc/fZh/39ejgcY4w==
X-Received: by 2002:a17:903:388d:b0:2dd:143:d5 with SMTP id d9443c01a7336-2dd6c75a396mr43870995ad.22.1789378503638;
        Mon, 14 Sep 2026 02:35:03 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc2d3bsm46109865ad.48.2026.09.14.02.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:35:03 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org
Cc: josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 4/5] selftests/rcutorture: Fix double nerrs count in srcu_lockdep.sh
Date: Mon, 14 Sep 2026 17:34:18 +0800
Message-ID: <20260914093419.1474829-5-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914093419.1474829-1-kunwu.chan@gmail.com>
References: <20260914093419.1474829-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_PROVE_LOCKING is missing, the deadlock-detection loop
and the mixed-SRCU-readers section each increment nerrs once in
the configuration check and again in the common error path,
counting the same error twice.

Remove the stray increments so that each error advances nerrs
by one.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index 72791499dd96..3acaffe52c78 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -56,7 +56,6 @@ do
 			if ! grep -q '^CONFIG_PROVE_LOCKING=y' .config
 			then
 				echo "rcu_torture_init_srcu_lockdep:Error: CONFIG_PROVE_LOCKING disabled in rcutorture SRCU-P scenario"
-				nerrs=$((nerrs+1))
 				err=1
 			fi
 			if test "$d" -ne 0 && test "$ret" -eq 0
@@ -126,7 +125,6 @@ do
 	if ! grep -q '^CONFIG_PROVE_LOCKING=y' .config
 	then
 		echo "rcu_torture_init_srcu_lockdep:Error: CONFIG_PROVE_LOCKING disabled in rcutorture SRCU-P scenario"
-		nerrs=$((nerrs+1))
 		err=1
 	fi
 	if test "$val" = 0xf && test "$ret" -eq 0
-- 
2.43.0

