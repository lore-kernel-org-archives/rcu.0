Return-Path: <SRS0=Bg9d=3J=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E9FC32771
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 22:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A911217F4
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 22:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8/RztKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgATWf1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:35:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34461 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgATWf1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jan 2020 17:35:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id w5so835518wmi.1;
        Mon, 20 Jan 2020 14:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7y+9jcXPCSZhEx3NX+qoACFZGUpTqdiKM8//qksV/wQ=;
        b=e8/RztKUTOxk4TpVS0UaHQ7AW9nnb/saWhB32I4djbutPSNabLAyUcp2F5s+5lOjAL
         LiN0siarHL8RNGI/YLUy1bvafhxUNeLp2JGNxIup899i50z7nCFAcegP1HhpKYXPWQp/
         RsDvLtSVOP9Sp1ugLkjLzq+U22PnWE4wc8KM05IrEc08dANFerzmHbxKt6qjYvoz8wSM
         8pPCRz5GVXtdfqR2HtESeRIA9YxnXhox95j1rjK2SM2B3QKgpep7i/IE6GLbM41pYm4R
         dk+FFR9hFuH2vMntj+/I3U6IvAHbqMg0P6Gpx3m+ENY/MED6i7QJjMkFCBWkcP5cxdku
         mbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7y+9jcXPCSZhEx3NX+qoACFZGUpTqdiKM8//qksV/wQ=;
        b=Al7kkJ323iWjuvqY/qc3RFUGyj/Ldu0yxghd4yELBML1prR+O3RS2In1ByG4T9lVJd
         KEqOzVy0ikivuFA+voEOiBPtBjR7eJgP/yFFFiBXXXKkUE0Ed8n+jHzm9G5FZ6twfDyn
         lEPJLWJiGZYvXACH/uEALGsoMR+tXtkAxb1vcn2SFwzkZJN81a+52WvLAK4DntkGGrwa
         ETXCOR+fCslbj1x8FRMJ/dyLqPBxvzBZJ+K1il6l1mBL4iOVIT/jOD4t7vNWbFE0aeC3
         5tv6CbxKyEMrTMOkxxBbIMos+CWbNqa+8M3U5VyOnkS4RA4HvopJWa29qgAHVu38+jpF
         Ycfg==
X-Gm-Message-State: APjAAAWZ6Y66lstRo593AxFvDCGik9fj7l12XOY9jqbaTJaVBESJQk49
        9HjsZW3Sg5iCVYKCAKeeh0gOmjVNei6M
X-Google-Smtp-Source: APXvYqwfucQ7OKW5yitDW5nNdnnZ48z8RtghuViGeJ+elzu4gbmME8rQaw5EBWB5OkcQHl/gC8bhhQ==
X-Received: by 2002:a1c:1f56:: with SMTP id f83mr912984wmf.93.1579559725274;
        Mon, 20 Jan 2020 14:35:25 -0800 (PST)
Received: from ninjahost.lan (host-92-15-170-165.as43234.net. [92.15.170.165])
        by smtp.googlemail.com with ESMTPSA id f207sm1213744wme.9.2020.01.20.14.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 14:35:24 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 0/5] Lock warning clean up 
Date:   Mon, 20 Jan 2020 22:35:15 +0000
Message-Id: <20200120223515.51287-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This patch series adds missing annotations to functions that register warnings of context imbalance when built with Sparse tool.
The adds fix these warnings and give insight on what the functions are actually doing.
In the core kernel,

1. IRQ and RCU subsystems: exactly patch 1 and 3,  __releases() annotations were added as these functions exit the critical section
2. RCU subsystem again, patch 2 and 4, __acquire() annotations were added as the functions allow entry to the critical section.
3. TIME subsystem, patch 5 where lock is held at entry and exit of the function, an __must_hold() annotation was added.

Jules Irenge (5):
  irq: Add  missing annotation for __irq_put_desc_unlock()
  rcu: Add missing annotation for exit_tasks_rcu_start()
  rcu: Add missing annotation for exit_tasks_rcu_finish()
  rcu: Add missing annotation for rcu_nocb_bypass_lock()
  time: Add missing annotation for __run_timer()

 kernel/irq/irqdesc.c     | 1 +
 kernel/rcu/tree_plugin.h | 1 +
 kernel/rcu/update.c      | 4 ++--
 kernel/time/hrtimer.c    | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.24.1

