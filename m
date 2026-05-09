Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A04396B84
	for <rcu@vger.kernel.org>; Sat,  9 May 2026 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337057; cv=none; b=qidQ6+vc4w+SagI2XCo/5l+qDvl1qW9wPBKqKGziGyJotXPbyzCMHMoPsl5dwDQlpxEXLGRG2A8/eJemBrzOWCrzkLk5ywkhuI5XKeedPCwyBfW1UHOrk2cGeHavUQfxFpiXMecDrPDMOjNf6P0zlywFEwHZV6xjhhXqktB8QxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337057; c=relaxed/simple;
	bh=6C9t7mvLqJfxIdsk1XSEzgDDg6fGZGpJmzji3OPwvLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+51iSK1G9XBFcTgkBWp4F6bSnrsyzJXOYrBYnqPTMv2HkNwb1MKsaLL5dc/CfSU0YToXJMaWp7QQepKXHek66ew07dmptGVFLx2bfegvmiaRtW+Ybm/r87RUu1fjRM7egoETalmFjEtrtrqb/K3Y93ela7lZDoV88aYVgqps9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smqSW/wx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smqSW/wx"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48d102471a4so28641445e9.2
        for <rcu@vger.kernel.org>; Sat, 09 May 2026 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778337054; x=1778941854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xCmQVKLqRiICM0wl4m0nAkVH1pHoZdM7w1jihSXzkk=;
        b=smqSW/wxlM0Sav59f8a77AT9cDgR7YJKLoyO3KUpEbL5NF8HBJsainE2DVejOmjwcy
         ZIdPk5Di+0+mQnJ6uZMRf8Tiy16nLppPuhnS3Ewjwzg05Wxa3yebJzG0ONoNEZmqpF6D
         CS7sAvSSm0oTTWx+Z3tefMGbMHliz/YsHJVqEi4MfXdVwOZg6fVaIyT6WLPTPKdJaSo9
         qzFK4S84kmbiafx3JaQxzqXcj7BaqAJi3p08pwT1yh3Kc1+mtiCoY+OFn7b8A1M9IhpM
         m/phXSf4BWROiOBtejpRG164IYbVSo43ToiywqKY+9hUyO/SB06VVRKOHoYmLmAc454G
         dxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778337054; x=1778941854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xCmQVKLqRiICM0wl4m0nAkVH1pHoZdM7w1jihSXzkk=;
        b=kIHnxDAouiEs+630I6rI2FKmC0x3T5hKD0iv+1VOrUwz5m/sOrgj5DSu86HgCDCr/j
         FQsl7cnt7IrPAQy4i+OsJhcs77FVU0tePoylfZU+0xxTkm05ijHfw39rAAtIyKq8UI/S
         mIf9qfdtIXkiGfeIKM8DWwMpWY/QyO4PL9ZbwKJEXyqjZWIhGJLgaJE6PISM1qyl+XGJ
         FZCKyefXyM/SKwU6/oFKIEf7XilQkKV03gS8Tfzi/HLvJ9cxu2ZfADtDTRoEpiuihGLK
         RXwHiGzYClBAWaYnG9hY4xRn8WcC3I5FSe90agSyV5GB9AyZf/C32a7+BnF/Lt0Gw6lA
         6m7A==
X-Forwarded-Encrypted: i=1; AFNElJ+JX4pPpm4WbXBKr01fGKEDcp4l2pyBSSElOjCEVqNVajlqszUS0Isuw3k5MroWsdP5iuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsnvWCi+RkeJaXQueUgbB+oinE7ApHPhgmBwFoALSG2H3iE6ub
	u+mr1teKeU8MsHTwXLqtbRP+jTAwAClxQ8iGoK1n9pXtPpUY710MB5Dx
X-Gm-Gg: Acq92OFzvW4h79mwgYLRghkNqs9cPxWph9y6MFB9T+RwMP13l7ubYcGqkQKZEnk37GC
	DazZurRyd7+N25tr/hZZ9vstZQDghp2TB8P65d5dVKAF+Y8Ve9VIOirLb6OKEidTPVAEa5PBf6c
	h3CVc1XZ4f10R1yZYOLM9rUXMvLvtzgH1EuVUOjQ2a7sd43+3Qdji1JmMp4Aa/icSY2s3IInaTC
	1JSxgbTrWdHodbzUYjdDxutXSOnRDPbFki4aH0/zS9+o92AJPQ9GOfEqkd/Ec0D76lYvLAi55gc
	YyPnc6HLni+GHnaKNwxea7XGQnJ8YnUHP1Gy7tGFsxlH2VW9n1tVPfDxNtSdre0JGYEoHGjkb3H
	1nweqePWDo9TZxmDyyahaOuUkGcEfHjuJ93W4xaZQIUNF03j7iUC67lipt2eJ7j3Di3mkD95sd2
	cZrze7RL/6x6o+gQUHV3tJK4GkJOCBwg/MeBjCpZO5zsjjWcUhiqbFu4tZTwRnX3V/2+u3Wd38K
	/W8zw==
X-Received: by 2002:a05:600c:524e:b0:489:1d74:56d with SMTP id 5b1f17b1804b1-48e676c14b9mr106487865e9.29.1778337053396;
        Sat, 09 May 2026 07:30:53 -0700 (PDT)
Received: from arey-arch ([2a02:1210:7298:ec00:73f0:d2e7:188c:1f61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e5614sm55015505e9.9.2026.05.09.07.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 07:30:52 -0700 (PDT)
From: Adrien Reynard <reynard.adrien.08@gmail.com>
To: paulmck@kernel.org,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	dhowells@redhat.com,
	mhiramat@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com,
	rostedt@goodmis.org,
	skhan@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	pc@manguebit.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrien Reynard <reynard.adrien.08@gmail.com>
Subject: [PATCH v2 2/4] docs: fix repeated word 'that' across documentation
Date: Sat,  9 May 2026 16:30:50 +0200
Message-ID: <20260509143050.16458-1-reynard.adrien.08@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
References: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicated word 'that' found in RCU/rcu.rst,
driver-api/driver-model/overview.rst,
filesystems/netfs_library.rst, trace/histogram-design.rst
and trace/histogram.rst.

Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
---
 Documentation/RCU/rcu.rst                          | 2 +-
 Documentation/driver-api/driver-model/overview.rst | 2 +-
 Documentation/filesystems/netfs_library.rst        | 2 +-
 Documentation/trace/histogram-design.rst           | 2 +-
 Documentation/trace/histogram.rst                  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index bf6617b330a7..110f3d42cace 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -32,7 +32,7 @@ Frequently Asked Questions
   Just as with spinlocks, RCU readers are not permitted to
   block, switch to user-mode execution, or enter the idle loop.
   Therefore, as soon as a CPU is seen passing through any of these
-  three states, we know that that CPU has exited any previous RCU
+  three states, we know that the CPU has exited any previous RCU
   read-side critical sections.  So, if we remove an item from a
   linked list, and then wait until all CPUs have switched context,
   executed in user mode, or executed in the idle loop, we can
diff --git a/Documentation/driver-api/driver-model/overview.rst b/Documentation/driver-api/driver-model/overview.rst
index b3f447bf9f07..4360cd5200be 100644
--- a/Documentation/driver-api/driver-model/overview.rst
+++ b/Documentation/driver-api/driver-model/overview.rst
@@ -55,7 +55,7 @@ struct pci_dev now looks like this::
 Note first that the struct device dev within the struct pci_dev is
 statically allocated. This means only one allocation on device discovery.
 
-Note also that that struct device dev is not necessarily defined at the
+Note also that the struct device dev is not necessarily defined at the
 front of the pci_dev structure.  This is to make people think about what
 they're doing when switching between the bus driver and the global driver,
 and to discourage meaningless and incorrect casts between the two.
diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index ddd799df6ce3..715218e1b233 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -626,7 +626,7 @@ A number of members are available for access/use by the filesystem:
 
    These are set by the filesystem or the cache in ->prepare_read() or
    ->prepare_write() for each subrequest to indicate the maximum number of
-   bytes and, optionally, the maximum number of segments (if not 0) that that
+   bytes and, optionally, the maximum number of segments (if not 0) that the
    subrequest can support.
 
  * ``submit_extendable_to``
diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index e92f56ebd0b5..c25587f411f2 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -738,7 +738,7 @@ creates its own variable, wakeup_lat, but nothing yet uses it::
 
 Looking at the sched_waking 'hist_debug' output, in addition to the
 normal key and value hist_fields, in the val fields section we see a
-field with the HIST_FIELD_FL_VAR flag, which indicates that that field
+field with the HIST_FIELD_FL_VAR flag, which indicates that the field
 represents a variable.  Note that in addition to the variable name,
 contained in the var.name field, it includes the var.idx, which is the
 index into the tracing_map_elt.vars[] array of the actual variable
diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 340bcb5099e7..ca619499ce28 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1700,7 +1700,7 @@ to that rule is that any variable used in an expression is essentially
 'read-once' - once it's used by an expression in a subsequent event,
 it's reset to its 'unset' state, which means it can't be used again
 unless it's set again.  This ensures not only that an event doesn't
-use an uninitialized variable in a calculation, but that that variable
+use an uninitialized variable in a calculation, but that the variable
 is used only once and not for any unrelated subsequent match.
 
 The basic syntax for saving a variable is to simply prefix a unique
-- 
2.54.0

