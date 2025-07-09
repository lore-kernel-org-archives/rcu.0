Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275B28DEFC;
	Wed,  9 Jul 2025 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057869; cv=none; b=RSn2BfSSdkUtvrpJ1X8QaXjD+8/kCkqCB9I1jH84A2I7u7NrOxfqzAbmo+zSxYuBO7Ibe52QTwS7QkKdDURwGJOn+VyMGudAwPgq7aUXTltxMjP/xBRGe097TtSd1mvXs+zRyVijutMKGulXOfjyeqbWaWIG8MZ4d0pD22HbV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057869; c=relaxed/simple;
	bh=w7SaFM6D/+f2nFwf3hbOKCIhux9M5xRlecLz0xuBf2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=C6CNza40NsOcHVvTihKB7ZsVKHe3rOZHbYBT+bhFLo74NTr+nW6SgS3hnmJyT88jwa7BIykKw1Xi5/oNbhv6UhC7VOsRAXnUtfB8jp04NTSw57Uhj1yws8pk2n4trAeb/zpdMsCvJKYO4D9eIGlLZhzoL8E9rw+jNHM+Bc0BnVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOIN61tZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOIN61tZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552ADC4CEF4;
	Wed,  9 Jul 2025 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057869;
	bh=w7SaFM6D/+f2nFwf3hbOKCIhux9M5xRlecLz0xuBf2Q=;
	h=From:To:Cc:Subject:Date:From;
	b=YOIN61tZvvKFvtFV+hxBPOybYk9W3vysr2GA9bo82GXFNISoRkf8PXDlPiwAKn0m7
	 dkwj0NwcbzqG8NQj9gltR+75jNVKf8WMs8fB/N/OJ2HbaPjEEhxe0vT9KNsJ2IiLX6
	 RGdJ3sASzb4vC0TUWQ6YoZMd5DNLYY3204lbrBeqohdDa89YL2KZDZ4XtSNhbHbQ4R
	 TI8D1qwjvJYfGYpR0/MizByMLaxHWbRX+UhuUl9qRygVXYKIjcnLVgVWOMU+/ytPY1
	 yeXDs7A40MZEdSY2yEbrcAv5DrGOXsxUoVORkuMtZ5poJIqtPIpUdmSAQVdLcQU09U
	 NtmF5AiTdJFzA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 00/13] Torture script changes for v6.17
Date: Wed,  9 Jul 2025 16:14:01 +0530
Message-Id: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>

Hello,

This patch series contains following updates to the torture scripts (rebased
on v6.16-rc3):

Paul E. McKenney (13):
  torture: Suppress torture.sh "Zero time" messages for disabled tests
  torture: Permit multiple space characters in kvm.sh --kconfig argument
  torture: Make torture.sh KCSAN runs set
    CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=y
  torture: Default --no-rcutasksflavors on arm64
  torture: Default --no-clocksourcewd on arm64
  torture: Provide EXPERT Kconfig option for arm64 KCSAN torture.sh runs
  torture: Suppress "find" diagnostics from torture.sh --do-none run
  torture: Extract testid.txt generation to separate script
  torture: Add textid.txt file to --do-allmodconfig and --do-rcu-rust
    runs
  torture: Make torture.sh tolerate runs having bad kvm.sh arguments
  torture: Add "ERROR" diagnostic for testing kernel-build output
  torture: Make torture.sh --allmodconfig testing fail on warnings
  torture: Remove support for SRCU-lite

 kernel/rcu/refscale.c                         | 32 +-------
 .../selftests/rcutorture/bin/kvm-build.sh     |  2 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh | 15 +---
 .../selftests/rcutorture/bin/mktestid.sh      | 29 +++++++
 .../selftests/rcutorture/bin/torture.sh       | 78 +++++++++++++++----
 5 files changed, 95 insertions(+), 61 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/mktestid.sh

-- 
2.40.1

