Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB44C65
	for <rcu@vger.kernel.org>; Sat,  8 Jun 2024 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717848483; cv=none; b=gKfCW6/8daKzDhN5v2jdE/Uyp4Y2a7Js8uP/8zs6XtNLJy8l9MZ4IaGTY806lseQbSmN0uhjG0QKR5R+g+wxV6CoIAZPDvxN+RVpCvedIKN2p5RqaRMaT6fk7GYt2/hEG/BezlKWbNZ79Qx5oriPoHe7GqOMBB1nuUfAyO7ONUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717848483; c=relaxed/simple;
	bh=GgYAa9550Pch0bRAbfsvJHat41KwkWRFcMdTNDecigg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7yWfJXN3qasidIDVfeIbGrqtt8HN+Rabkk/T5EdflZtF1nDoQmRagtHDywZjMidTmpBSfHeO9euNp0kIJ5F9s02MgbwGZfWAJzlde8a1lLfMnjUWMV3ZFAnJTEdS28eqXFyYvCYxcNuxlN75R51Y1y4VzhOTA/PGy4sotEjdzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOjUgQc/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOjUgQc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717848481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tihwQeLY+L4QDzE6e4TVA4azaI+U0hokqGYwbyGDbK0=;
	b=eOjUgQc/DglBNWsFgNyNrqlyLIpMwcDelK1OuXHb0KcClckSzNmRLK2Hkm3B9G+0jXCBYv
	TySYYwSOaNUPhpGqY0qaB28RHG56BN+34VGTnp7xR026eMsYSw0he5wk/v6xuUFYx1yVi9
	Gv83v3mqTRBzS04EByfVKtWzjNGGWrk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-zlWpO-0fPniZi4a9zdfHxg-1; Sat, 08 Jun 2024 08:07:52 -0400
X-MC-Unique: zlWpO-0fPniZi4a9zdfHxg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0C7885A5B5;
	Sat,  8 Jun 2024 12:07:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.55])
	by smtp.corp.redhat.com (Postfix) with SMTP id B0AB21C060A4;
	Sat,  8 Jun 2024 12:07:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  8 Jun 2024 14:06:22 +0200 (CEST)
Date: Sat, 8 Jun 2024 14:06:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Rachel Menge <rachelmenge@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Wei Fu <fuweid89@gmail.com>, apais@linux.microsoft.com,
	Sudhanva Huruli <Sudhanva.Huruli@microsoft.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	Joel Granados <j.granados@samsung.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH] zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with
 TIF_SIGPENDING
Message-ID: <20240608120616.GB7947@redhat.com>
References: <1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

kernel_wait4() doesn't sleep and returns -EINTR if there is no
eligible child and signal_pending() is true.

That is why zap_pid_ns_processes() clears TIF_SIGPENDING but this is not
enough, it should also clear TIF_NOTIFY_SIGNAL to make signal_pending()
return false and avoid a busy-wait loop.

Fixes: 12db8b690010 ("entry: Add support for TIF_NOTIFY_SIGNAL")
Reported-by: Rachel Menge <rachelmenge@linux.microsoft.com>
Closes: https://lore.kernel.org/all/1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com/
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/pid_namespace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index dc48fecfa1dc..25f3cf679b35 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -218,6 +218,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 */
 	do {
 		clear_thread_flag(TIF_SIGPENDING);
+		clear_thread_flag(TIF_NOTIFY_SIGNAL);
 		rc = kernel_wait4(-1, NULL, __WALL, NULL);
 	} while (rc != -ECHILD);
 
-- 
2.25.1.362.g51ebf55


