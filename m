Received: from mta0.migadu.com (out-253.mta0.migadu.com [91.218.175.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE64492E32
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983234; cv=none; b=rRqksB9Vehu89ZKeItusv4giD2cr92cA0/1iaV9kOMn/Y2x9ZDVR5TPFwmKlLtXQvrlq7PMMWRBECXZtz4jAXBI57GM1FFVUfaTHMDXeXXe0se6yFe9KROTuq9S5uSS4zYkGzwJCSWiEC7G16RnXz362ZlTQP19Ty1s2NAFsVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983234; c=relaxed/simple;
	bh=EYCPbF4GXVvVmlhwTlUPGyo1CDrWSEx3JYzEGtOW8IA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYqrYQtA3Iz1GEOpBfzOVF/x0ifrMHK2hXEWJwaTeDmT8pQ4XyGg5xKc3LXlMQ6JiRw0PQ1v+ft6qgAWi7bJnX9v8U89cRU6FMaq8nxulNNG1uD6/3c8SdkGkLoGXt+vSlvQbqoTsCAbfkZWTXxEOIHS+uZ0+oYS4BSCx7mmwZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FEhrKxGt; arc=none smtp.client-ip=91.218.175.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FEhrKxGt"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EYCPbF4GXVvVmlhwTlUPGyo1CDrWSEx3JYzEGtOW8IA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789983230; v=1; x=1790588030;
 b=FEhrKxGt9s7lgZ8WqPH7VDOpF9udhJxQW05bDn7s2BKy9QTjk71eT9cayi63uddxNYwj6pZi
 5K7kE42mv1lqv4JNC/vhgbvMckfm+eqadNwsvuctYY/1cp0g3ALobxhSCCSOuCV6dsZP5DUu63i
 1S/f/93BjKz+hEZFsUypIk+I=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5246bf0a6504571f;
	Mon, 21 Sep 2026 09:33:50 +0000
X-Mizu-Trace-ID: 5246bf0a6504571f
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Ye Liu <liuye@kylinos.cn>,
	Justin Suess <utilityemal77@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Gregory Price <gourry@gourry.net>,
	SJ Park <sj@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	oleg@redhat.com,
	tglx@kernel.org,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
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
	babu.moger@amd.com
Subject: [PATCH v4 15/15] security/landlock: convert thread iterator to for_each_thread_rculock
Date: Mon, 21 Sep 2026 17:33:33 +0800
Message-Id: <20260921093334.105291-1-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260921092101.89285-1-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
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
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
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

