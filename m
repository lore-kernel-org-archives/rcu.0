Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67014E2E7;
	Tue,  7 May 2024 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074538; cv=none; b=aK6JfATTN4pFa0jAPMhrAwqWmBUnHOe4TCja3IfMOudaO+iI0Ey0EYmxRBj2wG1Extg0JHnQqKNcXzDi1gONgbGGC/3loTessFr2u5Ih0ufcmcR+Tyb4ZctDHD/MEhpBQjqFsan7FQ1sr0hZto7pBJq6TxR+4mqq5xkckkQwATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074538; c=relaxed/simple;
	bh=gnS9CcaEQlXpIi1QO4y2SeHwVRYTfdUPzWNA0ABAbJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dlCCYjPgg9cOymn1+Jsfw9/2AI25wo1QaNzqU+BhUm9DWxtVWP6nfgIPfZh9/bkDSByMAvbeo6+J4x4AYelZt7AXe3Cqpeor2HERhftQScfypE59bbq/N+/tDvoutw10dOb0/O+1dBvXgCCqg7UseKcixghMNqPDlQpUndcHMFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQv1Y/LI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQv1Y/LI"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e2c70f0c97so36444451fa.0;
        Tue, 07 May 2024 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074535; x=1715679335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKSxKw3J4u17pMf8rY4oBSyEujXxW/P4ah2ldg1dFIM=;
        b=MQv1Y/LI9peGIksVlJHcV/PjTapie5DQkGg4WuOSbewgUt7pb8ZAQ9Cyd9ih/HG1o2
         crRzx+5L0B2wuCzJnE6Co9QDY25eqfQHIMzK3Q66/rGFBQ8mXhagYnsxz1UcE/+UGOIR
         y7cW7vESNZq94zkfFlUo3/Er7UebHSg3lp5/z87ZVHsBqw1cGB5Mqq7VAVFgKfvW0Hsr
         Ymwx+bjEJgzhDd8a07tXyUpYo/QcpfTedaXDKCTX2RTAt8oWHDHGz8GoYftOwTcpZS0r
         OCv/IKiHc2+ZBr/595tS7V8MjPrNzlotpbkzSF8taQXDaQUE26QIh+5e3OzdQGacWDpk
         4WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074535; x=1715679335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKSxKw3J4u17pMf8rY4oBSyEujXxW/P4ah2ldg1dFIM=;
        b=DF1jGAAqh2KWmZey9mZ4rAf/wCG5zIViz7V8QQrDKRJh88Bz+6CYZcfjC3R5Q6AJkn
         Lqvbw0b1j/bdcDZ7dUoZPHtBiFQp7JqWuGvub4j/UTIWmyLxOpk147b7oce+GD9WwnQE
         dq9Pp9CbON5Qh/cC3kmWnugBRnYqPu+JExfHtfBlaxAg/lmEEJZyAmK822JjCj3xphQr
         XnomeLsCSWHErjfjHfxaLwK9335cC1kJhF2xD9BA7iIr8iQGXggRNE7EGXIfdsqdHvJA
         HhZlyZQhkaliR3X+hmjYcXiLpz10ShT5aBrctWa3RJaXKDsqxdRoXXTNJkRpQRgoKvnI
         LPng==
X-Forwarded-Encrypted: i=1; AJvYcCVW1VNSHYVgkclxOl+JZdfS0yCgym/bX7bMAPgAYVQ+1yDRzXrnX7zvAJTr6v+qMc+6TM8ygaRP4YbitWdOWtrG45Os/blLQAOs6ptL
X-Gm-Message-State: AOJu0Yxsb62SGe1T59swG9h9U1gmH8zkUldu3+BCgvHpKtUcH3KZ9Vem
	+6+m9QjVTSh41B2eorTjOhSRbjW4cfgioKcDCTHZgp1ZaTn6hLyx
X-Google-Smtp-Source: AGHT+IGw1vTX1PP1f28XdFs43ofUOjMPjmA6T0iqArywpnhpbVZBrbGOZls0Ql5fr4s0md0S/FAbeA==
X-Received: by 2002:a05:651c:1035:b0:2e1:ebec:1ded with SMTP id w21-20020a05651c103500b002e1ebec1dedmr7848663ljm.25.1715074534369;
        Tue, 07 May 2024 02:35:34 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.33
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
Subject: [PATCH 01/48] scftorture: Increase memory provided to guest OS
Date: Tue,  7 May 2024 11:34:43 +0200
Message-Id: <20240507093530.3043-2-urezki@gmail.com>
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

The tradition, extending back almost a full year, has been 2GB plus an
additional number of GBs equal to the number of CPUs divided by sixteen.
This tradition has served scftorture well, even the CONFIG_PREEMPT=y
version running KASAN within guest OSes having 40 CPUs.  However, this
test recently started OOMing on larger systems, and this commit therefore
gives this test an additional GB of memory.

It is quite possible that further testing on larger systems will show
a need to decrease the divisor from 16 to (say) 8, but that is a change
to make once it has been demonstrated to be required.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index bbac5f4b03d0..42f0aee09e51 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -425,7 +425,7 @@ fi
 if test "$do_scftorture" = "yes"
 then
 	# Scale memory based on the number of CPUs.
-	scfmem=$((2+HALF_ALLOTED_CPUS/16))
+	scfmem=$((3+HALF_ALLOTED_CPUS/16))
 	torture_bootargs="scftorture.nthreads=$HALF_ALLOTED_CPUS torture.disable_onoff_at_boot csdlock_debug=1"
 	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --configs "$configs_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory ${scfmem}G --trust-make
 fi
-- 
2.39.2

