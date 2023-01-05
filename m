Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8904C46467
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjAEAlB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbjAEAil (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBDBB11;
        Wed,  4 Jan 2023 16:38:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B820161892;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17289C433F2;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=5gCrufnnSVpPm8uAIzNsafH1DxAklWprFMYPiBys5Bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZ1lIREtKmRTkJ5EF8pKnxbhCtjBbIpgLsnrJSVSPH1uSfJoMfE1TQKGNZxGZoKsU
         sMIGsYXJLHYBU+Lzx3VcHZfSTAbu5XdwQdYWDfhrn+NaLOTPYCjkZssVV/VWoW/dUT
         KTHlXQRroF6D5dhGSurYZA0DYelfWXPKMo4kaeifWePnPXnSn5xfoVqAsVWZati6OO
         KiA4tEK3jyYssjJ0kAbIZXP0ktiWPJBkdZm6JRbTFrDD3sIo0k0dvYQ9T3UJn8fxLu
         z/VZfH72zA+54zNCMSZXzhruIKT3gAneZU4YxHA+heiufnTti+VSyVepnj7IgJTk6v
         LKqL2eaoJ9zDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BBFC15C1456; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH rcu 04/27] arch/powerpc/kvm: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:37:50 -0800
Message-Id: <20230105003813.1770367-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in selecting it.  Therefore, remove the "select SRCU"
Kconfig statements.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: <linuxppc-dev@lists.ozlabs.org>
---
 arch/powerpc/kvm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index a9f57dad6d916..902611954200d 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -22,7 +22,6 @@ config KVM
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
-	select SRCU
 	select KVM_VFIO
 	select IRQ_BYPASS_MANAGER
 	select HAVE_KVM_IRQ_BYPASS
-- 
2.31.1.189.g2e36527f23

