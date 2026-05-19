Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A919C3B635C
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219933; cv=none; b=DlwEzQGSb59SJZiyaw+dg6LDR/J91fbNSaXO5wdP5NpfrXJjjwhDRux/N8CCaTv16pt0PwRm1hXY9aPZk5lgrym/yAr0YyfvjI0mUCNuld47v7YH4nQzJJ/i168UQH2W66VoW+QfBKXwuNtkiWwACB5xYvlm9GMg+IoLn3kL5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219933; c=relaxed/simple;
	bh=yg95+jA4OYlmIgo8aira0sfiDymydxJc4HtaxzIjeEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byguIUC4spmMunuE72Rk4kPJrlO6qVum+1aoe9C+eIYW8ekV4xOuPS30MttOvnm6bxrWj08qEddmGq77hMuB2vpmhqpVjfYpKtMJMZJWrst7RELCQY+8DphkG/6uxQelh3qcv4AyE47abjow08ZSjQeVwQ7aMIBiNaZDYx0EBXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeRou4nT; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeRou4nT"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-392445f11c5so44287711fa.1
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 12:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219930; x=1779824730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFj4IX7pq0ONh+1KWCITkzOOtXQ9yoQpVR86RbaYawI=;
        b=GeRou4nTJvMf5XlDAYHVy0+XnuYv5a250c+UAnUKrAPilRIgG8PcwbKcvb4ujlK2nh
         XhqjYA0EhvHToU29jW9tLzfxQ++AnSxNcb11otRrn5SQDvXVGxaT+FJdeV+YSycvF1nT
         wcTLZerPVzrujrCaMoOHsE9Li4lEoHF96FwKxUnjwb37SJS1Yvz0X3idTtjYm4JassXj
         McT4X10dw9n50cadmlJI6I24Za/rUutolUNkFVhxTsOYd7lTgS9MmhH8SnIk0H/b8tOP
         MS9a3alirydrkoIgiJHcsUwTVNqhN0qFG2scm/ZgkT4zFIPQqf2WbnO77THHhWQjnvWZ
         rr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219930; x=1779824730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AFj4IX7pq0ONh+1KWCITkzOOtXQ9yoQpVR86RbaYawI=;
        b=XGJAMrjwksHtHIh+sZbQxQsjrK61yAfPFRsOQtxK4ih7Tv3dil6rJTFNP4aeIp+EaI
         d5SLFtKhqEWLyhCb3WnL6/+v+m/5h5LFwWHYqX2A55TsIXNFOzA6NnI4EGBzo/4FpC2+
         72dBjxxJI+2cpXbu66FdnsYClHdQmcbiXclSIWvx5GGRB2ofg9/EqJeE3+T4461RLCmk
         q8b4SNSZhAUUOWKZD4aqEfT7xLw783dDnwo/VqOI/TUKQ7Srb1RH1iyxoOeSlHPz4yzx
         uLojnSFy1S/Mh5vj4IodA7J1GEqjUEERpqj8F8negfFSqu7gD3aIAsQMiGRFukX10DR8
         e77w==
X-Gm-Message-State: AOJu0Yzeim1AKXovcZJeSgUMU3BJJp5KLK0BM4wq2j9T7IQDTPb0sxb9
	uoq//Reb8nGtWZjyGANQIIwezBJfT+iErmRom8oCAydSVtEvzcAeFjVk
X-Gm-Gg: Acq92OEhIeJuJtK9PNLAXX+HfzQ/JV072cNvy6pmG4jlry9e8U9orbHtIBdPEfzbplV
	pDZqB1EBJs2Z04iiunydDAj8oqEXj5j5DicZk+qiSnR1EhZUA/+mSIwj45zNvvByYEwq+8TJ5Vo
	l7FHYh7+0tDyzty2Y+emLVbmnygodr3NB7HIwte9Jcbb9dXLA3cAOXc3kfYE8nZRy08VpR66yiZ
	nti6hBNJeU/tkSe2V8zEEFYFbzRuTpN+pJPdQpNKEShdbSpWoQ7wNH5mXB2I78GzqcN54y9qFq2
	u5l8YJkP72R5u2yQHUEuQwhvFuoUAVHZCdsLVddZdz7kHXGrk8bpbHqufeURzXe7uH94d0kRGnT
	JqU5gFtf6kt/FHsTrsS96iCxK4iazbrUc2qOJ0VwqHa2LbxAbHySjxUnfHAxTjO41+XeEPW0hrt
	le9MoquA6UiAMJIiI=
X-Received: by 2002:a2e:bd03:0:b0:38e:866c:4340 with SMTP id 38308e7fff4ca-395608e83dbmr61040481fa.6.1779219929771;
        Tue, 19 May 2026 12:45:29 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec3fsm23558761fa.9.2026.05.19.12.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:45:29 -0700 (PDT)
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
Subject: [PATCH -next v2 06/11] checkpatch: Undeprecate rcu_read_lock_trace() and rcu_read_unlock_trace()
Date: Tue, 19 May 2026 21:45:19 +0200
Message-ID: <20260519194524.158515-7-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519194524.158515-1-urezki@gmail.com>
References: <20260519194524.158515-1-urezki@gmail.com>
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

