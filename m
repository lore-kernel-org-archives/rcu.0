Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CCE478E49
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522100; cv=none; b=FSwTWSkaVXoiZbX96gIEI4lLVD6Nv3xnDaggB7WWPRz+Y1z1xFveflBxQubJWbRCP1/JFiw/Kz3NbZxYY5Z8dP9/c8YXW/WbM3RMoJhABjjfmreYiN8AG+w5BKkg5NfA1kDAE3C7xvcX48Ubm3LDp7M+UNB5Q5yCCl6ttApcwx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522100; c=relaxed/simple;
	bh=yg95+jA4OYlmIgo8aira0sfiDymydxJc4HtaxzIjeEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQY0IRpjhuRxnCJ5SHIDFu4rz5rPh90xF5FVbYHq4anCGXkd9FV/Y+vWVxooOExclR+r5Lso8tmjmU+n8z8enD+UZ3JCbJ6xEY2AwzgTJHJE1qfgxpw0h+Z1WCtqf2TulBzx2pV/V11gEBxbgzNwW8w/dgLnXeTXzrq8HdkKUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3MU2aUA; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3MU2aUA"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3938cc204a7so37305101fa.1
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522096; x=1779126896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFj4IX7pq0ONh+1KWCITkzOOtXQ9yoQpVR86RbaYawI=;
        b=p3MU2aUARkCvcDmRt2fQMHJcUFDqMd7RGb+iAFIXZdDrexpy6tHTupRzLujP4Q3Xnc
         e3e4bJcO2I+dtkaMfupr2OA/WnngH2p0wL83qDj4JxjhGDTeqe5rVWOJ39rzTO7AoNfO
         kdews+gM3eBeVATqtjUElMC6qfwKJcQrx4PPIdnvYQEAD3vSkEcDJABw4lVa88qAUHBx
         NGgTyk7DJ9Ia+PsL7/qlh6kV/F/B7RZNsKo4bgr/5wI66iuneddC0yAN6hxcaL7TK7k6
         o83mLqmclSbCTZXVOsHYetF90WkbGebMWwZRJIAazq3XNDKB2FkHIZ4tnmetVrtq4DUr
         +H0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522096; x=1779126896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AFj4IX7pq0ONh+1KWCITkzOOtXQ9yoQpVR86RbaYawI=;
        b=SBbLvGoGD9tIVSGhQ/PU6eNkKnHtZBiU0ldst72F4WJTY8VqmV40NjpKC3seWG5O9f
         ayONh5u4PhQtCxF4lXwkm4XL6Y1tASIL+MPt5rn6kaBuXAuGyZ3bucai7giPmS+76KR/
         Q/pH9hBHg0RSw3zQb/cYxgj0ljJ1o+VEVE+D/ryDbou66OabaBWm651lWRZYavElenZx
         tTHDqBIrXrtyE1sZOFIP5cQ7C46j2qY1BQtudQYKAkaQ9+0xG6zCMUmzW3KM4c+Mmilg
         H55FlGJEqgDrRPcY+w3C3cbp535i4WJFiEYDG+znF5FMIbK1X8BdS/DWh0EpnH8FP72q
         OuEg==
X-Gm-Message-State: AOJu0Ywutlb7jOD6kZwzB4jqM6ZkhaBeOzTAF+1XKESuf0AGvPqz7hKJ
	qs9lt/t6wchmHtFRxRTDMEEadpH7IPYvGLWfz2AILx0gQlwdiqkh7ddD
X-Gm-Gg: Acq92OHmxCwUIbon7nJxfR5mvmUy/Phz3v5+pg38pCQ8FwJuP9Ox+hqxZ/DvZ2FRUXa
	vI+QR6Z8WTNjqe7qRaX5+b0qHZhvIX0z2OXn2RR6aBVe0xQfv0Zj98grVxefcVJKLomrMROPKTW
	UE9uHqk6DhYE17daCypnnjIFJku3oo/GhhZfb1l2CFrXCfEJngixc/okWBNCar8BleSK0sHVpvj
	1GHkFvw+XdAYJcOyV0FF6Lhgyqr7WBrjYwPgn/enbcEG+i5utXukVPyt7kona+Q5PXfQzwk9Vby
	jj63eeTYKPfRPusKeZQb00/mTNU5MBKl3HlcaLVgufWN3EwxGQTZ65xosDC0YOPlGedWvxABYwo
	7EaJE7ozd6Og4t4JmLDNIcLI+j9iYdz0htMeSIhP58A7k0c8uR1wHHexVWNI93clxfHYmObzB9K
	JxN5W3fgslOoTA7DfbtzOcZDFKQw==
X-Received: by 2002:a2e:be14:0:b0:393:5920:2c5d with SMTP id 38308e7fff4ca-393c432462bmr104321521fa.28.1778522095555;
        Mon, 11 May 2026 10:54:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f614a5f4sm28968891fa.33.2026.05.11.10.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:54:55 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH -next v1 07/12] checkpatch: Undeprecate rcu_read_lock_trace() and rcu_read_unlock_trace()
Date: Mon, 11 May 2026 19:54:43 +0200
Message-ID: <20260511175448.153326-8-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511175448.153326-1-urezki@gmail.com>
References: <20260511175448.153326-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

It turns out that there are BPF use cases that rely on nesting RCU
Tasks Trace readers.  These use cases are well-served by the old
rcu_read_lock_trace() and rcu_read_unlock_trace() functions that maintain
a nesting counter in the task_struct structure.  But these use cases incur
a performance penalty when using the shiny new rcu_read_lock_tasks_trace()
and rcu_read_unlock_tasks_trace() functions, which nest in the same way
that SRCU does.

This means that rcu_read_lock_trace() and rcu_read_unlock_trace()
will be with us for some time.  Therefore, remove the checkpatch.pl
deprecation.

Also, the rcu_read_lock_tasks_trace() and rcu_read_unlock_tasks_trace()
functions are intended for use only by BPF.  Therefore, add them to
the list of functions that checkpatch complains about outside of BPF
(and of course, RCU).

Reported-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0492d6afc9a1..cc5bbd70cb84 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -865,8 +865,6 @@ our %deprecated_apis = (
 	"DEFINE_IDR"				=> "DEFINE_XARRAY",
 	"idr_init"				=> "xa_init",
 	"idr_init_base"				=> "xa_init_flags",
-	"rcu_read_lock_trace"			=> "rcu_read_lock_tasks_trace",
-	"rcu_read_unlock_trace"			=> "rcu_read_unlock_tasks_trace",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
@@ -7596,12 +7594,15 @@ sub process {
 
 # Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
 		our $rcu_trace_funcs = qr{(?x:
+			rcu_read_lock_tasks_trace |
 			rcu_read_lock_trace |
 			rcu_read_lock_trace_held |
 			rcu_read_unlock_trace |
+			rcu_read_unlock_tasks_trace |
 			call_rcu_tasks_trace |
 			synchronize_rcu_tasks_trace |
 			rcu_barrier_tasks_trace |
+			rcu_tasks_trace_expedite_current |
 			rcu_request_urgent_qs_task
 		)};
 		our $rcu_trace_paths = qr{(?x:
-- 
2.47.3

