Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA19C433FE
	for <rcu@archiver.kernel.org>; Tue,  4 Oct 2022 02:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJDCm7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJDCmc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:32 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B474E24976
        for <rcu@vger.kernel.org>; Mon,  3 Oct 2022 19:42:28 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id e20so7344508qts.1
        for <rcu@vger.kernel.org>; Mon, 03 Oct 2022 19:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qHMeLOfJoIrvE9fi2U/J5sqIQb82UDnKuhTxG+3+5zQ=;
        b=WEOsB+5qZH1d35I4d/f2NHtH7P/qhz+3Qst6PAka495OMpNlt8sDrS7968BC/n67h8
         om5lDmx9OSJCQKfgJsL0/CcTl0V0LxHR2ht/OnxMgImsVlevcuEeFXzZ/PvkkQDVM1El
         FKNqOeHxZyofEBK2s50J13JTImjSrJLLdgu0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qHMeLOfJoIrvE9fi2U/J5sqIQb82UDnKuhTxG+3+5zQ=;
        b=wmf4LcIdo2idCiJl3dBmKzGgr+K/SJh9jTdlIIn7gVusRXYKepm6DHySVDXdyaYgx9
         rMLEheq9nwWdPPO+5xyDrG9SLmJ9pxxViuYZEJp7i+BVRoU8SiSu+L7MA8XWBsbireKs
         bjIGmfEUrM2H/D8ZGeQyEE87Fo46CyqA2Qds62Lr71ZktY7GtOpjWq6AUExin1IPW3YE
         I/dki8UobV3GHaxst33S2xRxHWZ4HgVEkgijSE310WYLlhB5uXr3xXj5if7VgK1vLVmY
         tstj2ZfXVT2ERab9zB9J7zByy7u+cYpuHdZWSbUpqGN/5wbksa36+xzUo1JFr5xgQ2ia
         v0WQ==
X-Gm-Message-State: ACrzQf2lpHEFSHIXLyEtNgZPRgaChkvkaoXtpq7sJyZ7gWC43H3D9e27
        4ApagDIX/HI2Uo1QEPj6p0jO9pEpIk8COA==
X-Google-Smtp-Source: AMsMyM749wYYgpntHIZ9XTkrQjZ2yhgo13uQYn8I0QiKB5i3NqrnNJ1sa/qQhQsQMj5KWOxBJDc2yA==
X-Received: by 2002:ac8:5741:0:b0:35b:b52b:ca9e with SMTP id 1-20020ac85741000000b0035bb52bca9emr18086163qtx.653.1664851347372;
        Mon, 03 Oct 2022 19:42:27 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com, Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v7 10/11] scsi/scsi_error: Use call_rcu_flush() instead of call_rcu()
Date:   Tue,  4 Oct 2022 02:41:56 +0000
Message-Id: <20221004024157.2470238-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Uladzislau Rezki <urezki@gmail.com>

Slow boot time is seen on KVM running typical Linux distributions due to
SCSI layer calling call_rcu(). Recent changes to save power may be
causing this slowness. Using call_rcu_flush() fixes the issue and brings
the boot time back to what it originally was. Convert it.

Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/scsi/scsi_error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 448748e3fba5..a56cfd612e3a 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 	 * Ensure that all tasks observe the host state change before the
 	 * host_failed change.
 	 */
-	call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
+	call_rcu_flush(&scmd->rcu, scsi_eh_inc_host_failed);
 }
 
 /**
-- 
2.38.0.rc1.362.ged0d419d3c-goog

