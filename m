Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E10C43461
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F1C20E65
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897074;
	bh=4AuojR95FSb5tOK6DNtw+xzMg2K0zUYedN74DX3J48o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uo3wmvBVeizQ2Hr8uGanrBn/YEIWbaPmCsrg6tZnlPxYZUYJbL5jLjy+MCm7iCBaP
	 DGiOKmhzO9UBRk41+4/XLnw6Wz+KPc6CKAw+1SpJrxqllzSvbc+w+M8xQuBT50t/cO
	 8PV2QNy9quuwJaHvb+an1+cxOTLOG+KdsiHTKvZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgHaSEP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729357AbgHaSEK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:10 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E34C20866;
        Mon, 31 Aug 2020 18:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897049;
        bh=4AuojR95FSb5tOK6DNtw+xzMg2K0zUYedN74DX3J48o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w5sof7pW2UOxew2g3qI8k3wfzXyh5mmPAxdDWyq4OofffDkHhQ3/xqmWwgk3Ykbrb
         KvbtCxnwWok06lpEDnEtBb+Sknpem8n3iuoRxocD9T9AAlhU6vVQH3KYYqZDPnjUth
         ZO+2tAwUSlPjnt4pCHTmM4Hk5NYSO8KVvQrxJtMs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/14] rcutorture: Replace HTTP links with HTTPS ones
Date:   Mon, 31 Aug 2020 11:03:57 -0700
Message-Id: <20200831180406.494-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Alexander A. Klimov" <grandmaster@al2klimov.de>

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/doc/rcu-test-image.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt b/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
index 449cf57..cc280ba 100644
--- a/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
+++ b/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
@@ -36,7 +36,7 @@ References:
 	https://help.ubuntu.com/community/JeOSVMBuilder
 	http://wiki.libvirt.org/page/UbuntuKVMWalkthrough
 	http://www.moe.co.uk/2011/01/07/pci_add_option_rom-failed-to-find-romfile-pxe-rtl8139-bin/ -- "apt-get install kvm-pxe"
-	http://www.landley.net/writing/rootfs-howto.html
-	http://en.wikipedia.org/wiki/Initrd
-	http://en.wikipedia.org/wiki/Cpio
+	https://www.landley.net/writing/rootfs-howto.html
+	https://en.wikipedia.org/wiki/Initrd
+	https://en.wikipedia.org/wiki/Cpio
 	http://wiki.libvirt.org/page/UbuntuKVMWalkthrough
-- 
2.9.5

