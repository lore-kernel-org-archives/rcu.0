Return-Path: <SRS0=P5Uu=WI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC26BC31E40
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 21:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AADE2070C
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 21:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UV4VNRqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfHLVt2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:49:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41556 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfHLVt2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Aug 2019 17:49:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so39802138pgg.8
        for <rcu@vger.kernel.org>; Mon, 12 Aug 2019 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+VX5r5f5cF5tCseJubpffqLGoYoFIqCd8nAOS2Bnab0=;
        b=UV4VNRqK2V8oXdZjI846lm0TvkYgelhm3Z/ShKpmDvnsa4yJznguBzAfmFOXQ52rno
         4wOBsmQBdzQlqfQHDVU0OmgLqZ/+pv6lyhNVJOnmpeHAHfv+uq8u4oGh0dGkOioLchI8
         RArBmprnuppbf9ZOANtkSWuTHWE1xQnkXrGo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+VX5r5f5cF5tCseJubpffqLGoYoFIqCd8nAOS2Bnab0=;
        b=O/6Prz2ivuKHaprh1aulMURZwnHLEQyqA3XKGgbt6hQ+8OW+zDuo39LymTjn6jhRQm
         WayNvfTNoQTbaV8OGx9aSXiTO42l+lCgPCKGMk1Z+J17xuB4j7yMn/65MBKzU6K4+bpZ
         fYJxFL0fnxD2do8uUADjWPsGmjfUTmOZW5bp9ok2gAT+SVn15M8O3u0nLyRGywUS41Nf
         X3TuX342QGbBiVnYKdHo0EPNht97DNMYwiamPQwPIAvHt7oUgcvUSmMRPD5M7gsI7nyl
         dd+nyHZSlpnHZFjTGmFqqDf5pQ9G9wyICLgrcDMYLPoRdvBCMXQLYD9HUZHVR7Koz9pe
         WSiQ==
X-Gm-Message-State: APjAAAXXj5gYua8HJKxiSfywpY6W5TZa/F70PmocwVUMxxe/TQx/fOgz
        9RsRKKZ4fJNOatNzl5dWvOtn8Ksu3Ag=
X-Google-Smtp-Source: APXvYqwpk5HoZYOES56dT5Hrqd5iS4AYSjw/VkhuQw+LHdOhVcm8tSvP24x6GNfHSM8kduo/3ggB+w==
X-Received: by 2002:a62:e910:: with SMTP id j16mr38564939pfh.123.1565646567232;
        Mon, 12 Aug 2019 14:49:27 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c5sm5434978pfo.175.2019.08.12.14.49.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 14:49:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kernel-team@android.com, kbuild test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] driver/core: Fix build error when SRCU and lockdep disabled
Date:   Mon, 12 Aug 2019 17:49:17 -0400
Message-Id: <20190812214918.101756-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Check if lockdep lock checking is disabled. If so, then do not define
device_links_read_lock_held(). It is used only from places where lockdep
checking is enabled.

Also fix a bug where I was not checking dep_map. Previously, I did not
test !SRCU configs so this got missed. Now it is sorted.

Link: https://lore.kernel.org/lkml/201908080026.WSAFx14k%25lkp@intel.com/
Fixes: c9e4d3a2fee8 ("acpi: Use built-in RCU list checking for acpi_ioremaps list")
 (Based on RCU's dev branch)

Cc: kernel-team@android.com
Cc: kbuild test robot <lkp@intel.com>,
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
Cc: Josh Triplett <josh@joshtriplett.org>,
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
Cc: linux-doc@vger.kernel.org,
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>,
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
Cc: rcu@vger.kernel.org,
Cc: Steven Rostedt <rostedt@goodmis.org>,

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/base/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 32cf83d1c744..c22271577c84 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -97,10 +97,12 @@ void device_links_read_unlock(int not_used)
 	up_read(&device_links_lock);
 }
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
 int device_links_read_lock_held(void)
 {
-	return lock_is_held(&device_links_lock);
+	return lock_is_held(&(device_links_lock.dep_map));
 }
+#endif
 #endif /* !CONFIG_SRCU */
 
 /**
-- 
2.23.0.rc1.153.gdeed80330f-goog

