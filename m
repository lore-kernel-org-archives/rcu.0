Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4197FC001E0
	for <rcu@archiver.kernel.org>; Tue, 15 Aug 2023 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjHOTK0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Aug 2023 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbjHOTKQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Aug 2023 15:10:16 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693F81BE6
        for <rcu@vger.kernel.org>; Tue, 15 Aug 2023 12:09:51 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-349a1cf0ae2so20375305ab.0
        for <rcu@vger.kernel.org>; Tue, 15 Aug 2023 12:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692126590; x=1692731390;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNj070RLyTuUaPJVeAHJLnmbdqPt3qMFEPUjovYEkRk=;
        b=WjYCSrq7A56vtRUVoV7qotEUe5yCSr0QzIEZ3bAmGe/O5gaUvfjR8bxWJNKYKk5w6u
         eS4wVUdSnLnButvaW6a0OWPo3+4QwvAZ2fcOJz3E98sZWCn6W6YSCazIHEKzxOX8rFcI
         gHxyNGLpnCsv7qsYbYFharB7SKFQMPbdTDO2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692126590; x=1692731390;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNj070RLyTuUaPJVeAHJLnmbdqPt3qMFEPUjovYEkRk=;
        b=RYpPgZjpzwpMhlIVrW1glpmjD8z7n5//f8/FAc+/PEK0ABAN9lO5NFdjx3iKx/jwCz
         FTaLXkftkRMk+3OE9s2wtQ6cc6mkJl00L98Ho0OFdttcbDr0VkJfF+zqBgFQoGHXFbM2
         MJark5Vi5Jk62Je53q8GnFuIVGprTUeKJR82MLzwXDnthkD6YJGMQu+59asLmGmLpavc
         5K4NJmKw1vi/9mWJ4VwW41yPsWrvt3sGva2rQHojoEfiUHY/5R2Bnbe//9skeb7lGNqg
         QibJTn8qfSuGUEpZlxjzhgrWoPBI8skX1GmDw2FbofpGNiYYDomDpWkCoj/Lc6t2VS+0
         BHXQ==
X-Gm-Message-State: AOJu0YxBQKRIKDfkwBtpigLwmDKCoIYnHedXV9sxy2yKSbVRgwez9gxH
        T0zMfZTfG7/5ydvTGwPmKe4FNj4iHGQ/i+ZW8RI=
X-Google-Smtp-Source: AGHT+IFpCDY7trQRG6cp/LxmZFhOBcNsdIbyEFSLsLs/Hd3i+vBHfSUhqXC3aM/q1j0Cjrzg8hC/8A==
X-Received: by 2002:a05:6e02:13ef:b0:348:6f4a:c341 with SMTP id w15-20020a056e0213ef00b003486f4ac341mr17372320ilj.25.1692126590710;
        Tue, 15 Aug 2023 12:09:50 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id l7-20020a92d947000000b00345e3a04f2dsm4137010ilq.62.2023.08.15.12.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 12:09:49 -0700 (PDT)
Date:   Tue, 15 Aug 2023 19:09:49 +0000
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joel <agnel.joel@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3] rcutorture: Copy out ftrace into its own console file
Message-ID: <20230815190949.GA3207581@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When debugging, it can be difficult to quickly find the ftrace dump
within the console log, which in turn makes it difficult to process it
independent of the result of the console output.  This commit therefore
copies the contents of the buffers into its own file to make it easier
to locate and process the ftrace dump. The original ftrace dump is still
available in the console log in cases where it is more convenient to
process it there, for example, when you have a script that processes
console output as well as ftrace-dump data.

Also handle the case of multiple ftrace dumps potentially showing up in the
log. Example for a file like [1], it will extract as [2].

[1]:
foo
foo
Dumping ftrace buffer:
---------------------------------
blah
blah
---------------------------------
more
bar
baz
Dumping ftrace buffer:
---------------------------------
blah2
blah2
---------------------------------
bleh
bleh

[2]:

Ftrace dump 1:
blah
blah

Ftrace dump 2:
blah2
blah2


Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
v2->v3: Updates from Paul. Also handle multiple ftrace dumps.

 .../selftests/rcutorture/bin/functions.sh     | 24 +++++++++++++++++++
 .../selftests/rcutorture/bin/parse-console.sh |  7 ++++++
 2 files changed, 31 insertions(+)
 mode change 100644 => 100755 tools/testing/selftests/rcutorture/bin/functions.sh

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
old mode 100644
new mode 100755
index b8e2ea23cb3f..a5c74e508e41
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -331,3 +331,30 @@ specify_qemu_net () {
 		echo $1 -net none
 	fi
 }
+
+# Extract the ftrace output from the console log output
+# The ftrace output in the original logs look like:
+# Dumping ftrace buffer:
+# ---------------------------------
+# [...]
+# ---------------------------------
+extract_ftrace_from_console() {
+        awk '
+        /Dumping ftrace buffer:/ {
+        buffer_count++
+        print "Ftrace dump " buffer_count ":"
+        capture = 1
+        next
+    }
+    /---------------------------------/ {
+        if(capture == 1) {
+            capture = 2
+            next
+        } else if(capture == 2) {
+            capture = 0
+            print ""
+        }
+    }
+    capture == 2
+    ' "$1";
+}
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 9ab0f6bc172c..e3d2f69ec0fb 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -182,3 +182,10 @@ if ! test -s $file.diags
 then
 	rm -f $file.diags
 fi
+
+# Call extract_ftrace_from_console function, if the output is empty,
+# don't create $file.ftrace. Otherwise output the results to $file.ftrace
+extract_ftrace_from_console $file > $file.ftrace
+if [ ! -s $file.ftrace ]; then
+	rm -f $file.ftrace
+fi
-- 
2.41.0.694.ge786442a9b-goog

