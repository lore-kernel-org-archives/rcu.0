Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6040756B
	for <rcu@vger.kernel.org>; Fri,  8 May 2026 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258285; cv=none; b=aMWEogl3uleCoy1YP+9Pj74Ua5xBuAfuoN1lDhECpyh4k/5ChsvObMzPXlDYSj5In6QJTKHe3DarXs8kD2BuX/ymC0mwU/6CmAqmnnaKKnxMMic6gc001PrpKU4pP0O9mXysZjwFHoPI7jtbz9X+KooofaiASQBwtGUReqYvNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258285; c=relaxed/simple;
	bh=UA//K5KE5lxyKxBn51gpSzesiAf2ti5tilN0wFiDEj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QStlqAVNgaRMcgO3WpU6Vw5hIItp9F/ra38zaXqsyu4ljuRnLNy2X6TcN+WYheulgin4ag3tsVdPy8n7+1Z37xsi+dSApKdhdue38R3HA/UhvdIyZ9PKRm++It/fg9Tdy29rAnelQLfEQSGzekNTdZF6YwUW2r4fJdtWPZVPc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsK3QfNl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsK3QfNl"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso1238335e9.0
        for <rcu@vger.kernel.org>; Fri, 08 May 2026 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778258281; x=1778863081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DTJW4BGtGQqxWbz4seH8/4tzQ7UIXmQ1TeDbULZ3Ovo=;
        b=gsK3QfNlZlD7oYfIGjgIx3NJkgEBskQXeW7Fljg4rZ4P97WRrFF64YSSQLaAw+5hSS
         Fjt5CyWi4F8K/DFbs1VlnDdsMAY4FExTHDKQyKNTnvKHUkKt21/HAuB6sPRaNJlvqF1J
         2Gwiwj0bjyjsLQR8moyAW6dxuby6EH2qbb66c0xXx6guSu71YcvevxdvC6DJeNqVkYVd
         Jo48EpS/zdfizpqHF3s84EZZVLpT0LYRPAmAW2Wjf3xqT0a4CEiXO7jneVadAYY7kC1C
         gXPRDKf9RWsWRMBLpnY9lBM3UKOrVjFDXmhrHgrgid6j4a0GG2O/1qTlnqXfD2L5OrTi
         /F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258281; x=1778863081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTJW4BGtGQqxWbz4seH8/4tzQ7UIXmQ1TeDbULZ3Ovo=;
        b=T3JJaOGjVK54/++shcxmYFZPhw4mfDriShge+/0zoOvYdVywgP3CT/58bLTXRISv+U
         uTqtzH9/XZN0arIqgMlCnYJqU7B255qAEUEIcI1Pyf5uehyJ7ClZ8RALGoRKGvkbwSX6
         N3DiUPOqVbIZ0Clid+NCfIGdy0XQnU4ZtB26nPzjRrNKXCD3IH+hX1cOVlmk9RlPkNtf
         CPXGAOBU9liHtOxVQuM06uC9LI+VCqmVHBVAnN/NKpEEgV0xuBDBuS5agsgSBcUJJ40T
         kXlU5OBH+bxbYrph/8+SBlbQQGJcwEFmvlFnvPeCuz4fELAz/fG5jq7WXMb0rnP3tYaF
         0GHw==
X-Forwarded-Encrypted: i=1; AFNElJ+go8PtchmiZmrXTv3FTMXELZc+Hdr3fpw7r7xIhGLaOhCoStfMbLtNNCT7e4vBDFSm0q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygn7RL4rGCYaVoYX1jkF5EvVARXaADYVgxNpm91DqTVBpOveiP
	AbP4uOLj/Fbsu0EEm1wwPVMbDQi4bSoTFYoFyOXw+9ZhWh/fpvZcOVqM
X-Gm-Gg: AeBDieuCgUPOjOarHShBWRgIM17759zPa2eHTvfhoPjDjIK0ljqvHKTTW452qVdtrMp
	Gj+u8bcrnfW551nTPIzkKrZWxLBxn50vDIVSVr1X++Kxh+isA3dZLLO+ds8/xmDTSsNmwwHL7yr
	ucoDe0t0LA8+Sz51zvjsWexrqQdYy144UVhGI6SucsBq2njvLRpLuGxKqUzympfZZ+grNKdPSnw
	Zau1H8OiyMhOeR7sHJrjYy9qUdn7KbueHrKXry/sjbltHpVKl2d88Nu2q22H4ZPI5PHSvJm/61T
	qr8unrFCUTAQkhPPAQV25hx8DoJFxsS2by1Q5h3DmtZ6jsyzRMuA81R8i5OwvOPc8GA54Pysrl/
	zvO9D+qXWb/9ozDu6IAUze2tvJmvdFn5B88ZoEMXFx7qSvjsx4/U96x8Wxpzj30ckNIPraygEXp
	yfpwj+WdKRP3WawP8esuvK6GZNiTbgE1JdONrDp4HvqUO+okodKSMyT8kAJ/W6ZCRgHhI=
X-Received: by 2002:a05:600c:8b0c:b0:48a:7a10:4f47 with SMTP id 5b1f17b1804b1-48e51e0a620mr219801715e9.3.1778258281158;
        Fri, 08 May 2026 09:38:01 -0700 (PDT)
Received: from arey-arch ([2a02:1210:7298:ec00:73f0:d2e7:188c:1f61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8e4f0dsm3379115e9.11.2026.05.08.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:38:00 -0700 (PDT)
From: Adrien Reynard <reynard.adrien.08@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	driver-core@lists.linux.dev (open list:DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS),
	netfs@lists.linux.dev (open list:FILESYSTEMS [NETFS LIBRARY]),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS [NETFS LIBRARY]),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Adrien Reynard <reynard.adrien.08@gmail.com>
Subject: [PATCH 2/5] docs: fix repeated word 'that' across documentation
Date: Fri,  8 May 2026 18:37:57 +0200
Message-ID: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
---
 Documentation/RCU/rcu.rst                          | 2 +-
 Documentation/driver-api/driver-model/overview.rst | 2 +-
 Documentation/filesystems/netfs_library.rst        | 2 +-
 Documentation/trace/histogram-design.rst           | 2 +-
 Documentation/trace/histogram.rst                  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index bf6617b330a7..320ad3292b75 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -32,7 +32,7 @@ Frequently Asked Questions
   Just as with spinlocks, RCU readers are not permitted to
   block, switch to user-mode execution, or enter the idle loop.
   Therefore, as soon as a CPU is seen passing through any of these
-  three states, we know that that CPU has exited any previous RCU
+  three states, we know that CPU has exited any previous RCU
   read-side critical sections.  So, if we remove an item from a
   linked list, and then wait until all CPUs have switched context,
   executed in user mode, or executed in the idle loop, we can
diff --git a/Documentation/driver-api/driver-model/overview.rst b/Documentation/driver-api/driver-model/overview.rst
index b3f447bf9f07..c1966d506d55 100644
--- a/Documentation/driver-api/driver-model/overview.rst
+++ b/Documentation/driver-api/driver-model/overview.rst
@@ -55,7 +55,7 @@ struct pci_dev now looks like this::
 Note first that the struct device dev within the struct pci_dev is
 statically allocated. This means only one allocation on device discovery.
 
-Note also that that struct device dev is not necessarily defined at the
+Note also that struct device dev is not necessarily defined at the
 front of the pci_dev structure.  This is to make people think about what
 they're doing when switching between the bus driver and the global driver,
 and to discourage meaningless and incorrect casts between the two.
diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index ddd799df6ce3..4033de4535ac 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -626,7 +626,7 @@ A number of members are available for access/use by the filesystem:
 
    These are set by the filesystem or the cache in ->prepare_read() or
    ->prepare_write() for each subrequest to indicate the maximum number of
-   bytes and, optionally, the maximum number of segments (if not 0) that that
+   bytes and, optionally, the maximum number of segments (if not 0) that
    subrequest can support.
 
  * ``submit_extendable_to``
diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index e92f56ebd0b5..949bbfdb0f16 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -738,7 +738,7 @@ creates its own variable, wakeup_lat, but nothing yet uses it::
 
 Looking at the sched_waking 'hist_debug' output, in addition to the
 normal key and value hist_fields, in the val fields section we see a
-field with the HIST_FIELD_FL_VAR flag, which indicates that that field
+field with the HIST_FIELD_FL_VAR flag, which indicates that field
 represents a variable.  Note that in addition to the variable name,
 contained in the var.name field, it includes the var.idx, which is the
 index into the tracing_map_elt.vars[] array of the actual variable
diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 340bcb5099e7..5b303fabdf32 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1700,7 +1700,7 @@ to that rule is that any variable used in an expression is essentially
 'read-once' - once it's used by an expression in a subsequent event,
 it's reset to its 'unset' state, which means it can't be used again
 unless it's set again.  This ensures not only that an event doesn't
-use an uninitialized variable in a calculation, but that that variable
+use an uninitialized variable in a calculation, but that variable
 is used only once and not for any unrelated subsequent match.
 
 The basic syntax for saving a variable is to simply prefix a unique
-- 
2.54.0

