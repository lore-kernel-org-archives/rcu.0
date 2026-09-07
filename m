Received: from mta1.migadu.com (out-58.mta1.migadu.com [95.215.58.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555444236C
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768947; cv=none; b=fsEIbg51JGgsuJIIUlJquFqsYoyeJ/JkuZfgZJ2OsYCLJbKuS6AXPjkwsO/KzG5DOidocix0subs4Vp4TklHmqRewx/kPzVOgZnKvdhBIG6uNRuWNPIh6GhEqWgmvYOE28JHt1KJmHzmJkwjgYA5faHLKmaxQaT3T1L8ZgWyYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768947; c=relaxed/simple;
	bh=QPbA87RHE+w44sKh8YFv32hrfoolvz7WuKZeL9giD2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLtg+utop0rkk4fkOyLIhFeWymIqZqJ8o/sWTHhzIAjyOqbCNq+Ha6oGiTZ1yA7T+A0VHdYC7V5HTkLhpOhGdWpWWGh/oni+Wq0UPyDKpeT5/PhteYNVyzNkr2hN1dklhkIwTmS4/8QMxGa0JaQCW0hr2RCXcLMqxCRdaP7psgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D6N2PO/K; arc=none smtp.client-ip=95.215.58.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D6N2PO/K"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QPbA87RHE+w44sKh8YFv32hrfoolvz7WuKZeL9giD2c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788768943; v=1; x=1789373743;
 b=D6N2PO/KskoCoIClayD3f1wX4et1e5e0XZHMrjm+yxesEXyETmfYNj0/eE/DGrvC5P+lcJsX
 NHgiqe2qaBsrhk+Io/1j+PsiAGVeO2ffRLRVUCYibQ7AhHAJF4zgdCKnmO64of7f6vJqft4eo7Q
 3fGo9ThEjTeqsTPXQSTCmGw4=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6d517d0bf0f3bdbe;
	Mon, 07 Sep 2026 08:15:41 +0000
X-Mizu-Trace-ID: 6d517d0bf0f3bdbe
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Ye Liu <liuye@kylinos.cn>,
	Justin Suess <utilityemal77@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	mhocko@suse.com,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	oleg@redhat.com,
	tglx@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	ljs@kernel.org,
	sj@kernel.org,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	will@kernel.org,
	boqun@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	x86@kernel.org,
	pavel@kernel.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	pmladek@suse.com,
	longman@redhat.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	mark.rutland@arm.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 8/8] security/landlock: convert thread iterator to for_each_thread_rculock
Date: Mon,  7 Sep 2026 16:13:34 +0800
Message-Id: <20260907081334.1152889-9-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260907081334.1152889-1-ye.liu@linux.dev>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ye Liu <liuye@kylinos.cn>

Replace guard(rcu)() + for_each_thread() with for_each_thread_rculock(),
which scopes the RCU read lock to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Reviewed-by: Justin Suess <utilityemal77@gmail.com>
Reviewed-by: Günther Noack <gnoack3000@gmail.com>
---
Changes in v2:
  - Rename *_rcu to *_rculock
 security/landlock/tsync.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 0b71e158c3f5..a578af640aad 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -335,9 +335,7 @@ static size_t count_additional_threads(const struct tsync_works *works)
 
 	caller = current;
 
-	guard(rcu)();
-
-	for_each_thread(caller, thread) {
+	for_each_thread_rculock(caller, thread) {
 		/* Skip current, since it is initiating the sync. */
 		if (thread == caller)
 			continue;
@@ -376,9 +374,7 @@ static bool schedule_task_work(struct tsync_works *works,
 
 	caller = current;
 
-	guard(rcu)();
-
-	for_each_thread(caller, thread) {
+	for_each_thread_rculock(caller, thread) {
 		/* Skip current, since it is initiating the sync. */
 		if (thread == caller)
 			continue;
-- 
2.25.1

