Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC114E2EA;
	Tue,  7 May 2024 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074539; cv=none; b=l6E/Sy3b5JHdI8A/uF7K05MoJVDYL+bfHmjRYTvdb2xzSSYTlR+3BagfZrCDWaFbwoR3HPNZX/hCHh3lLFHlNtZCDYG7HeIqZSeydVkBrMYBdZjuuVeGk36t9dOpPBgiW1xDeWXCp6elEGQL+M8Hlv5mSau9ASNpbUxkyKmGcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074539; c=relaxed/simple;
	bh=iNxM3spYrH6jeXcFwXys+CzMIvg4TpaHf/M60KZ2Phg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=leeZ/0vW3Afklv2V7Cl5ET+oebUEl2LEK0nGcoYifN9JGpjHFW+vDgcQTt0BobPTFiW4/c6EUUnivsbEVk/KND1XcWPcxQ/I/X+8Az+aoi4dL/1lU1Y3RZypKKI81O9bLkgTiSw+yrID4sXUbvcXg/lPXtSeBuJ0hPccp02eGHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWX85Njf; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWX85Njf"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e242b1df60so34978091fa.1;
        Tue, 07 May 2024 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074535; x=1715679335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/dZXNHdnJdCiQVj1yFaboz7N4dw9CdxnQ0QkyKzyjM=;
        b=dWX85NjfDU1dLHmn/LnX0juXUVZ5dbtLev98m1MoocgMfX6NKRaBzA9srQ31mCpH3D
         nmtLXmIH6+0C+5MOSDUlNSH5H5SWlFflJbo6OhZXcGxyn7o1G50KD8IcdiPaYGRurIzp
         5VF65KpvN1PtoahnOUXzKYZFZFg0S6Zm/ATZVArHXJSflL5ydsPri9aIwdkT0Vyb/xpm
         17Ej7Lfz5DkYjLIEZuVlD2EeMXF0eqQLO6okRXyKEYOXrbZ+SX/pmuRLBM+s9w2Ys35r
         dgIpfjMica+E9aBoiKX+p2/gqMPvVGqVPfbzdB1v6a3w0OPlkNYeDk93XVHUeXk+CItH
         HbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074535; x=1715679335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/dZXNHdnJdCiQVj1yFaboz7N4dw9CdxnQ0QkyKzyjM=;
        b=GBuyh7mBK9UDucaa3ih2hgZJ8gLPARFA8JqoUlHUsHueyKw6JnugHsKkj6MHwgC0KL
         6QU7cK5ECwyVBNKHgLFHcgxNyFg8hbmMiZzIv78vodq/4W6sms83i+DulDpqCJLkQ41H
         XcXdxiJTHz/rQLcPhvzsPob0VavgwAdtLJNLU6ToYAiHzJMbs8d9ilqyy1esjv/MZgQ0
         9HfuAXphKx0j1hcWm47S5i2TkCKPGvRAKR42GSud1zaLluYm8c20AoOT88Z2dwDZNtoz
         0HZTxcLdXB+OuMtd1CfOo4RfD6sO3zGlMgHNLazIHzEjbNFYXQ8qExkbBwfBLmSqbYL4
         bvkA==
X-Forwarded-Encrypted: i=1; AJvYcCX4cIBYFCZmRbQ0HkGD3J+N1427e1n+DkBuDiYjg8txDpFxyIZ5ZrUVs5bwE9p6bWyo4mEt5rKtv2V8D1HKFHssiZmFJX7xaB+7IG93
X-Gm-Message-State: AOJu0YyBYf6KRu5Gy2YIslssswvgLIV7EvzIbvCYRZrTC5M2jCUwFvn5
	brOtfe8IJtlPlB3w19KeG1jND5hpZWqwV1RbZfObcKbYF7J4CCeF
X-Google-Smtp-Source: AGHT+IHGTGPMhUFWAjkriGKAKoiR1qDCoYN8/LSNdR+hMlhqCKcWYj/0UPIAVbRMNGNQEoL6wqkafw==
X-Received: by 2002:a2e:800b:0:b0:2dd:ccb6:e836 with SMTP id j11-20020a2e800b000000b002ddccb6e836mr10197448ljg.25.1715074535187;
        Tue, 07 May 2024 02:35:35 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:34 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 02/48] rcutorture: Disable tracing to permit Tasks Rude RCU testing
Date: Tue,  7 May 2024 11:34:44 +0200
Message-Id: <20240507093530.3043-3-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Now that the KPROBES, TRACING, BLK_DEV_IO_TRACE, and UPROBE_EVENTS
Kconfig options select the TASKS_TRACE_RCU option, the torture.sh tests
of enabling exactly one of the RCU Tasks flavors fail.  This commit
therefore disables these options to allow this testing to succeed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 42f0aee09e51..13875ee7b050 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -391,7 +391,7 @@ __EOF__
 		forceflavor="`echo $flavor | sed -e 's/^CONFIG/CONFIG_FORCE/'`"
 		deselectedflavors="`grep -v $flavor $T/rcutasksflavors | tr '\012' ' ' | tr -s ' ' | sed -e 's/ *$//'`"
 		echo " --- Running RCU Tasks Trace flavor $flavor `date`" >> $rtfdir/log
-		tools/testing/selftests/rcutorture/bin/kvm.sh --datestamp "$ds/results-rcutasksflavors/$flavor" --buildonly --configs "TINY01 TREE04" --kconfig "CONFIG_RCU_EXPERT=y CONFIG_RCU_SCALE_TEST=y $forceflavor=y $deselectedflavors" --trust-make > $T/$flavor.out 2>&1
+		tools/testing/selftests/rcutorture/bin/kvm.sh --datestamp "$ds/results-rcutasksflavors/$flavor" --buildonly --configs "TINY01 TREE04" --kconfig "CONFIG_RCU_EXPERT=y CONFIG_RCU_SCALE_TEST=y CONFIG_KPROBES=n CONFIG_RCU_TRACE=n CONFIG_TRACING=n CONFIG_BLK_DEV_IO_TRACE=n CONFIG_UPROBE_EVENTS=n $forceflavor=y $deselectedflavors" --trust-make > $T/$flavor.out 2>&1
 		retcode=$?
 		if test "$retcode" -ne 0
 		then
-- 
2.39.2

