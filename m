Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384915CD41;
	Thu, 23 Jan 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737658714; cv=none; b=gKByp+tCmQrjsZgou8TN7VnK8/jA6yMigZr8LVDaUOy1sl9LhTIWM16h24/60/jjqmfM064ZrINeGugokmp4KWPMRqk/+h0bjnMJHRtg/FDQgRXXALxPPhsf1YzVogUh31YQut1UWjRWZe23njbpoQvOdbbZo6eELE51jjwWb1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737658714; c=relaxed/simple;
	bh=IUKbhUTV6qNRIQ6CrUPX0BLVJHE2EqTKqTbQbf4ECMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NZsMYfCNpsVA0/wifcCn5lvKGSkowVmJ+aoUlKkH/8z7t69ekHDWl9/7e3ylS6ogdeEH3L89HPIIHX1P8cUnhIUYYnGM4Yzli1KsFX7Gxj5VTU4vJ7OV56dLAO++EyxhXD5zT7LEwlvK/lZNGATSMpywQwiBl2SpxyS+LfWhxMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6avThUz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6avThUz"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5401ab97206so1343574e87.3;
        Thu, 23 Jan 2025 10:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737658711; x=1738263511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YaQKQ/zepaWFn+uFpcOiGerEdCgq6w0dgGCa8PCB/Ps=;
        b=g6avThUz+Yud3NNekrfgm/hhAlrt8f7lAmpA9bougqaQKt6yxugVX5g84ezLcwB2DJ
         f9TYPHRIJsEfNjTsJ7xiR7GCe8K+I3tNAGTBiBWilGip0WOxa3gyCzVSvc4wYmD6r4iN
         oG4/unD9Ivowr/nfjrU6Uq6POh4Xpu/+3+R+zZG0nex4e3ZOOEAjMq0pgE2Arq/3h4BW
         +MN4JpX6pUYXlv8647MBdwN09CvYQfqHa/5dHyPhnkQHeI35egBoRvBwlE1Oosf9d6sY
         v/wah1d+PYVn3CFyPpDbjr6qFOqHhNj2TlY/tuvz3iJD3I7sXpqunwfk8TaARClGQ/hg
         wLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737658711; x=1738263511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaQKQ/zepaWFn+uFpcOiGerEdCgq6w0dgGCa8PCB/Ps=;
        b=GOtbeoN1N4uP8d1W7F4oNaqf2MBu0MWgmy1LjItMFAu59CXNLHwDFcbirgBfVKygNJ
         kG8BHlphACcQugOq/SaB8U3Pz6rHd05w535QLYo0MXO+3UvbOFofvbGYr1G4VV6GEToE
         De8WU5Z0qQB1hs6TjN9myfbpoWR4722HzY84VMFU0oI1U8v/OV2LEtG2dQ1fxegz0zaf
         GLQcyZm0kCcKmvISAbhOuuJ2E/5rDhxU83r9wpFrY2PPLHEDkaA2X7nd1DtcoJo7yk5/
         lF4czKLnWU/QCsDPygJDN0wT6lmiAi1K1faIPbGxkJldhmoefaZDtJaqAks3Er54VTok
         RoSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxrSIOBschqeMvXHkbUtRfcAVJILryKVFNQl5SWxe7gqEBMiAWE+bKS+pmuixzAco90/XLRB3JFL5Vb4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaLOW+sNYP9kbJtfPQ3odYkreC4wwQwMpdgRslm051WO1GPe4B
	4Et9h6qg3F9kc4++gTZjtEPVM0v7icHsE8pjvJqsIMMG6K6QXBt+CmQ0dw==
X-Gm-Gg: ASbGncv79y7BtRgP7RhotwRR7wzYbri+f3q3NKtTHGuhYF0DRV6W322DGmMpFrMPCfF
	16Dj3l/1O0PZ7Xyv21PNtIaxQ9dKJRAPNH+fDNd//bd5bdR+pXHGGEkDWmc4tEv/s9v63nx48am
	0JnwXhDr11XhTb6NXogz9peVMKfpM/FxVSxLrAKSOFWttdr7EulMX+u0GeF9lhSfSstSOGNs2ia
	7wk52HhN+3/hLXNYkHgiDRe2kLXyCxPszbhk8TjapOEp9I4MxKPGmk9+M3sKlGt4eSGO/VcTs+R
	rSD3LrX9Zns=
X-Google-Smtp-Source: AGHT+IHh3AmH1ph+V8URM1jevFYQtKyPWBWH/uwqsjNOlAJTP3oOM0zdyWDbliYAHofpWqCLocjjmA==
X-Received: by 2002:a05:6512:2246:b0:542:218a:343 with SMTP id 2adb3069b0e04-5439c28af0emr10348519e87.52.1737658710689;
        Thu, 23 Jan 2025 10:58:30 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8368497sm9644e87.151.2025.01.23.10.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 10:58:29 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/4] rcutorture: Allow a negative value for nfakewriters
Date: Thu, 23 Jan 2025 19:58:25 +0100
Message-Id: <20250123185828.460836-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently "nfakewriters" parameter can be set to any value but
there is no possibility to adjust it automatically based on how
many CPUs a system has where a test is run on.

To address this, if the "nfakewriters" is set to negative it will
be adjusted to num_possible_cpus() during torture initialization.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d26fb1d33ed9..6bc161e1e8ac 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4050,6 +4050,10 @@ rcu_torture_init(void)
 					  writer_task);
 	if (torture_init_error(firsterr))
 		goto unwind;
+
+	if (nfakewriters < 0)
+		nfakewriters = (int) num_possible_cpus();
+
 	if (nfakewriters > 0) {
 		fakewriter_tasks = kcalloc(nfakewriters,
 					   sizeof(fakewriter_tasks[0]),
-- 
2.39.5

