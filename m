Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C371C7619A
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 18:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjCOSTx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjCOSTm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:42 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CA67DD25
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 11:19:34 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id cf14so17177730qtb.10
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSsc7hzk/lL5hF/xvXJ1JSJwgr8pnxi74tQwwkfBkI4=;
        b=PqxQOwNl8FLQlZ0wb/ZC52nN9ZdX6CCNAYQcZPAXaYrpYU0hoWExe1OhVcwOi1H5n/
         tohphBPoVr0QvcXjNSUxMn9KZ7gpbKM+U6MnHgj/YBjDbP7VpaVzoTMaQ6DzfIFXxWKt
         s150z+ZCa5wg6JrUs4FzWZglQlefFPSLnrV6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSsc7hzk/lL5hF/xvXJ1JSJwgr8pnxi74tQwwkfBkI4=;
        b=8K08ZdVqhtEgId+xeoZnjHeMlGB+Kwlw7499pDiyH5eGsCK87V5dXTfQHKOnMKYt5G
         EB9/Gt8MUvb/jB3H9phtgzo/tBYJ6W5Dk8FRNZSHzOJMFmHYLBYYV63R9EqbnsZmGfv1
         KUc2MNCrSLxzKnvawbM/O6ZG8JhgHrwbpNBT2XFLKXzH7BRGqYYNoDOk+5wBQpBkBtj0
         WpySHMDsUblzD1tOo/enlrhTGkngsb5T+8jm7DJ+X421eb1SZoTZ4SGq71CcV0F70Gh2
         +5fJfeLef+HrUPpaCPuB6Usa6XtAhMeEQ6BoitnnFVXOzx76Cdh1ZwJFLlCgfE1TyYjK
         cO7A==
X-Gm-Message-State: AO0yUKXfXae+C85LdY+WUWwF6WVJKeOTnJnHoe+EesS2Lc81PkUpw16N
        +RwG3DGb7k8pFkpiwtkA3zgVnw==
X-Google-Smtp-Source: AK7set8JXw73dwtTVWf2o1rrh79neNXmuiIN9SfzBb2Ehts755m8MFms900eo19kDXSQnwjRKYHqkg==
X-Received: by 2002:ac8:574d:0:b0:3c0:3b79:9fb0 with SMTP id 13-20020ac8574d000000b003c03b799fb0mr1372546qtx.47.1678904374217;
        Wed, 15 Mar 2023 11:19:34 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/14] torture: Enable clocksource watchdog with "tsc=watchdog"
Date:   Wed, 15 Mar 2023 18:18:56 +0000
Message-Id: <20230315181902.4177819-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit tests the "tsc=watchdog" kernel boot parameter when running
the clocksourcewd torture tests.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 130d0de4c3bb..5a2ae2264403 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -497,16 +497,16 @@ fi
 
 if test "$do_clocksourcewd" = "yes"
 then
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
 	torture_set "clocksourcewd-1" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
 
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 clocksource.max_cswd_read_retries=1"
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 clocksource.max_cswd_read_retries=1 tsc=watchdog"
 	torture_set "clocksourcewd-2" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
 
 	# In case our work is already done...
 	if test "$do_rcutorture" != "yes"
 	then
-		torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
+		torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
 		torture_set "clocksourcewd-3" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --trust-make
 	fi
 fi
-- 
2.40.0.rc1.284.g88254d51c5-goog

