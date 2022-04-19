Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93CFC433F5
	for <rcu@archiver.kernel.org>; Tue, 19 Apr 2022 00:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiDSASC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbiDSASB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Apr 2022 20:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDCB1401C;
        Mon, 18 Apr 2022 17:15:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 524B761338;
        Tue, 19 Apr 2022 00:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81F8C385A7;
        Tue, 19 Apr 2022 00:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327319;
        bh=S65r7n22pCGVAxcMBUGPgKWLKmOIZM4hiJ5VL9d4GIk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=r0OvyHlWOSb3cTx/WW89PXCXwvC1HQXCfqqhVQDKW6GA/sJZgedBVTfycWt4U1Uhy
         gxHm+0UZUo+KL7l+2O6UoFPFKNWNYyiwiinwH7UI7TNcv9YZU6fNVBpyzeelroPdLP
         Q/1JTBEMto/J+kEMe0bgYcmXfY/cxT8gSbN9jVqwQs2ZXMbUuZA03BAssDqOSJrMJT
         w7WC+h+myz2WlZsCMubuPFoaFjlrK2DWF8IHyqTOnI5c8nrrcomkmb9H17btKEQ+Ai
         AgBVJgQrHLvyt27fi9LXUxu95NooZAUzqi+UsFWHO3mDN8Dht2M+GlzLRBs3eEJjxF
         gGj8Bvu9+t7MA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5DF285C04BD; Mon, 18 Apr 2022 17:15:19 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:15:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/12] Torture-test scripting updates for v5.19
Message-ID: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains torture-test scripting updates:

1.	Reposition so that $? collects ssh code in torture.sh.

2.	Use "-o Batchmode=yes" to disable ssh password requests.

3.	Permit running of experimental torture types.

4.	Make thread detection more robust by using lspcu, courtesy of
	Paul Menzel.

5.	Skip vmlinux check for kvm-again.sh runs.

6.	Enable CSD-lock stall reports for scftorture.

7.	Adjust scenarios' Kconfig options for CONFIG_PREEMPT_DYNAMIC.

8.	Remove extraneous "scf" from per_version_boot_params.

9.	Save "make allmodconfig" .config file.

10.	Make kvm.sh allow more memory for --kasan runs.

11.	Make torture.sh refscale and rcuscale specify Tasks Trace RCU.

12.	Make torture.sh allow for --kasan.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/testing/selftests/rcutorture/bin/functions.sh             |    2 -
 b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh       |    2 -
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh           |    7 +++++
 b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh            |    2 -
 b/tools/testing/selftests/rcutorture/bin/kvm.sh                   |    4 +--
 b/tools/testing/selftests/rcutorture/bin/torture.sh               |    2 -
 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01          |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04           |    5 ++--
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE07           |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10           |    1 
 b/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh |    3 --
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh              |   12 +++++-----
 tools/testing/selftests/rcutorture/bin/kvm.sh                     |    6 +++++
 tools/testing/selftests/rcutorture/bin/torture.sh                 |    9 ++++---
 14 files changed, 36 insertions(+), 21 deletions(-)
