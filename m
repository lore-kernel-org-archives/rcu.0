Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009614A639
	for <rcu@vger.kernel.org>; Tue, 23 Jul 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726191; cv=none; b=ku/KzBUBINfrQEfoZSlh6zh4fE9oTdBi4uEZ8zdgYebbtx0TpK/ppsh893jfxU4V/TWiGnluo1rDb9PTMRjyMD9H7eQPLsGVmkwT6CMMmF0V3HJm23gQ9CxlxqYdz9QUOrfr55PXpFMSSDNA+p9q3yb/tsSMmxmKvgmlqTltMqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726191; c=relaxed/simple;
	bh=Hd+Zp0aBsPr1feqGkY1y/DXEsSV68OQ7+QxHo5IkEkI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dhpfX9TL0CUeTjJaLY4FTNT39b/XPYstLyayXkYxfoBUPjLFRi2JqvyTGiUEJA0aubrUKmuwuBw4MxJgxbzP481YnY6WhJR1OgFOf0FhJocNfkYxwTepPtbHC2HTvQYANcf01MJioKWkmz9r400wL1ZSpvcreBDALNonqHpfxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso4569009a12.1
        for <rcu@vger.kernel.org>; Tue, 23 Jul 2024 02:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721726188; x=1722330988;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KbgA6D5uIJRGc1fQUY5bhFFcW0uLdyzK3WlsYhEfrA=;
        b=sWM4rEE764LDoYN7Xl20VhXoGcfeohyJnx0wRfwfv1soFu276sGx38ICBe4GU+fy/B
         VDY9b06teBPIfpMSgtPdoGJNYPSNVDl5QyJ0ft1cWv1OYcd8hsnTgCY4G9qdUxTjggQh
         PCCV4jymC1VC9yQtlENE+oYB15ALfz8qQlP4kDWW6Z4JrQU/Ps2ZuIacRitdBhNof8gD
         LLFV/KuL5AnQuMkf+lEJDLzpRJMFP1Ip9uGWToSBcMJIAySafRwBYOf193xbSyExRVap
         VgF1RQ+a/6l1JB3RYoL+y0AJ0mB94JHHdkCN2Ldku7McSFr16brUhSn+UFETyAedCT8H
         mybg==
X-Gm-Message-State: AOJu0YzWc0L0a4GSJpl9Z480uN11owdXw66tMIPefE/1KQ2sgkZu8fwu
	6zhNsUDunHLji3dv76p5Y5I3QHW913yz6v9C7HFERXwz2DnY3iZs
X-Google-Smtp-Source: AGHT+IEg2iTLOHPTmARcuFGIg+GEK5bflyX5rsxasEcROASjTnE1qGODq2LIb6LRcWnne7lunzMZkQ==
X-Received: by 2002:a05:6402:34c3:b0:5a1:39cf:6ac0 with SMTP id 4fb4d7f45d1cf-5a3ee8a9d6dmr7552524a12.2.1721726187900;
        Tue, 23 Jul 2024 02:16:27 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c2f8808sm7181200a12.78.2024.07.23.02.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 02:16:27 -0700 (PDT)
Date: Tue, 23 Jul 2024 02:16:25 -0700
From: Breno Leitao <leitao@debian.org>
To: paulmck@kernel.org, urezki@gmail.com
Cc: rcu@vger.kernel.org
Subject: kfree_rcu_{monitor,work} hogged CPU for >13333us
Message-ID: <Zp906X7VJGNKl5fW@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I have some systems with CONFIG_WQ_CPU_INTENSIVE_REPORT enabled, and rcu
workqeues are in the top offenders with the following messages:

	workqueue: kfree_rcu_monitor hogged CPU for >13333us 515 times, consider switching to WQ_UNBOUND
	workqueue: kfree_rcu_work hogged CPU for >13333us 1027 times, consider switching to WQ_UNBOUND

Chatting to Paul privately, he suggested me getting the time spend in
the two workqueues/functions above, and I created the following script
to get the histogram for these two functions:

	https://github.com/leitao/debug/blob/main/examples/rcu_timer/rcu-timer.bt

And this is the histogram I get, when running it for a few minutes
(where the lines are in msecs):


	== monitor ==
	@all_monitor:
	[8, 16)               59 |@@@@@                                               |
	[16, 32)             300 |@@@@@@@@@@@@@@@@@@@@@@@@@@@                         |
	[32, 64)               2 |                                                    |
	[64, 128)              7 |                                                    |
	[128, 256)            51 |@@@@                                                |
	[256, 512)           157 |@@@@@@@@@@@@@@                                      |
	[512, 1K)            356 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                    |
	[1K, 2K)             381 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                  |
	[2K, 4K)             480 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        |
	[4K, 8K)             567 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
	[8K, 16K)            263 |@@@@@@@@@@@@@@@@@@@@@@@@                            |
	[16K, 32K)            25 |@@                                                  |
	[32K, 64K)             3 |                                                    |

	== work ==
	@all_work:
	[32, 64)              27 |@@@@@@@@@                                           |
	[64, 128)              2 |                                                    |
	[128, 256)             1 |                                                    |
	[256, 512)             7 |@@                                                  |
	[512, 1K)             15 |@@@@@                                               |
	[1K, 2K)              24 |@@@@@@@@                                            |
	[2K, 4K)              32 |@@@@@@@@@@                                          |
	[4K, 8K)              46 |@@@@@@@@@@@@@@@                                     |
	[8K, 16K)            154 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
	[16K, 32K)            85 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@                        |
	[32K, 64K)             3 |@                                                   |


I also broke it down for pid if it is useflu, and the output could be
found at:

	https://paste.debian.net/1324062/


Thanks
--breno
