Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087DB17C6C;
	Mon, 16 Sep 2024 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463320; cv=fail; b=lYrFSOticd4C8DSJ4usSpZ+WNB76nQQo1CWz1WGtBEJtoMpeSBKABlvWbfV4vqSwF8R8C9DRlIM12AbU5Nh0n0kwPN3XXMA+ZVhKwpNSe7tsuWOuN0orMGjJ8GeQF3hdxAGsh0VHMs3jV3OilJxODJDiG5CBeN4bTx4dbysQq/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463320; c=relaxed/simple;
	bh=JAi+mZo+Z2x61084uHR/zhhz6/khUiqOHvgcgROWnH4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KUkH3I9uFhkmh+6XOFNhLEtC9R12angim+zFrqskUAPQivUsqpnL84KVMHTYWfAjzpTxuVPhmqKiVObelbKlSBu8dyYv2C3x9R6cNgPwlxYf//1TnJwZ42Q0yMmWAvWvM1UzzcicSmnd2kfzppIvwr//LjEHUTFqPvlsVvkv0NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kwjwOpfX; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kwjwOpfX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgwVsWb4z0d1/3F7G8mZa+qKOSyTFjg0dw7nzZl/AJy6sXMGkIMdEfrPF/CGbfRs/rV2Y2BMIVcDtWPfBV1zzo+SUjsVwmMweGsuOW8LO5OeV4MHowiWddrtV3Wvn1R5dXfnxz5BXAEFO3GnUUyB7X3KmfEDTOirgjQ7ATWprtO1Zstn9huSpVnOE31WvUJiQjWvAGmoDqKKLxeAqVVxPubCrfL0zCr2sUW+Riru8sRaKISO7EIIJt/lzDsaiAoFq1yOD/AbRSghoi6Pg4Ahp8Ltt9XSHCRBY0t6HkJfAkhu2iWc6FmO/I6gRh6OyfQpEoksG9pSwKDns+CmSygY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv695J5QZzYGkUeobETRtESqzsIskAiUqQ7tWH/qp0U=;
 b=JVUzRs/N9S6L8jbgrY4IjHvq/MMhBDGHaH24yJFGeRby8lSdYD//ClPmqW+NHd7X+1QphVgHa76zlZuzL0Wf2xh4NBrSi8gHoZ1tXaSuPW82fvT8NKEcOxN3IngKPj9ZMbeO4rcJuoG5NqxydAXiCytTm6kmjTf1+O5/9ENFUlnT04EY8t/G4sJOJfe4lg9+tge1AlcvekrUsAxTcN7NcTO+tGatPK9aLL7vp4ZzLXF1dKoARdA1DPILx+U3lIBKJAh/Rq1nu3G5hiQ33FcsM4T1dlE5YhqY/lnBokgjNDCKOdAE5yaHpM8KQNVqAGtnfQ8et6BuJkdYf8X2gaz/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv695J5QZzYGkUeobETRtESqzsIskAiUqQ7tWH/qp0U=;
 b=kwjwOpfX69TmANdpioHyIOdS1PF64qu6nttXaaR4Xa4GqB3T2d1+VAnl+DbtlhmKDwuVPFM8ByKsTbgCnTGMbqx6+mvL2IrlKdLADU6wRKht5Mt7kW76ikTnwgawZYncMX5iLYMTijNbbPXCv63tYOMBh1IaZV8sRECD2YCjZ0I=
Received: from SJ0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:a03:39e::14)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 05:08:31 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::39) by SJ0PR03CA0279.outlook.office365.com
 (2603:10b6:a03:39e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.29 via Frontend
 Transport; Mon, 16 Sep 2024 05:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 05:08:30 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 00:08:24 -0500
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
	<gautham.shenoy@amd.com>, <Santosh.Shukla@amd.com>, <Ananth.Narayan@amd.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <paulmck@kernel.org>,
	<boqun.feng@gmail.com>, <vinicius.gomes@intel.com>, <mjguzik@gmail.com>,
	<dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>, <linux-mm@kvack.org>,
	<rcu@vger.kernel.org>
Subject: [RFC 0/6] Managed Percpu Refcount
Date: Mon, 16 Sep 2024 10:38:05 +0530
Message-ID: <20240916050811.473556-1-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 247d3418-1484-42e0-ab2b-08dcd60d9b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K0Lx8nxRwN8kQpZnPSsOlXmTwyVV4T6/2rK/A6g3tbPRJl4zKdLIn3XLdt58?=
 =?us-ascii?Q?Whz43P/wo5fLs8f19NaeUBu6OV8trp4jVUk0RsXH23hDrv3vz6xxXbX5b6E7?=
 =?us-ascii?Q?3WIJKDtvzmhDRBsKh9dXCmeXf7gWRTn1z2f2P1tjXTfRKOjz0jcr3O1qwA28?=
 =?us-ascii?Q?8L2/ngM476wVuhoBb78KXqqK+WbGDcRogtU/6Ou/GdyTAVM7zmjZaF8NeLBD?=
 =?us-ascii?Q?tHVzY+9G1P/OoV05BOYNbdH36Y8/DDleEH1eziQo7L0z2262lb7rmGsoCf5H?=
 =?us-ascii?Q?zBzxyJOkPyCbaC4TOajaPID4JZ47pOlaunqCw9sW1jfmXDFxJ2ALmWGO229J?=
 =?us-ascii?Q?t7Mfn0HH2CMMh8qTADf2rAfh3DNydjyvb3rithHjXbmFK8ef/ZwzTTdhs/2w?=
 =?us-ascii?Q?VfnaG1Nzh/eayZw9rj+i6kksmlrBBOI8gWHve23lFTtq4GkZ6Pse7g17mpMV?=
 =?us-ascii?Q?yvKQdTdRNVhwgQ2yrQ0BfYc8iew4oTUj+Cr1P2Y4wpXREZQG7jX2rvDC+H1K?=
 =?us-ascii?Q?oNDd7DEVbBMXykYvXmJHtaI5Zs6yzGNvFMTukY4SGXOBGbbgcTZdouA9/aRb?=
 =?us-ascii?Q?7305LTzshLwuWKbPxOMa6WOIT0Y89ilbee2hKnO4zwYzHxuAp7oPE/8DuztN?=
 =?us-ascii?Q?PgfCSwAcLhCNYwLXg9QefmavBGxQdLaidE4UaqxG7eLJMzjulH3Ep82EUDvF?=
 =?us-ascii?Q?zql40v9vrFttTViOnwdi+OrhOPbXuEryIlbAxlTE/xknHmfObaGRhFFP+jjQ?=
 =?us-ascii?Q?/9gsbWDxho/P5FzW7h9U7V3onfQ/xlU1Ye8LCwgOhEfVbhM3obC3cQfi5jMm?=
 =?us-ascii?Q?iuj92KCVnPIxnS7j4s/TZPf4oRufBhpLPWZ3h8fhao1GJNwn0S8LpZ/OpgcQ?=
 =?us-ascii?Q?dgZUyP5LNK7SnV42y7N4pyShFiHKpWzSoHENH4HxyNeTIEvvJnFDTLwgTVIz?=
 =?us-ascii?Q?mxjdVDPY0gM8y8xmX8MoDVQR4xP8Li+syhpKQKf52VYek41Bn2kqxUOe4l+g?=
 =?us-ascii?Q?ZPUp+Zt8NE3zzP1v8n3H9SlRb/MjTmn+WVP9DdtSilShDRJpc3BmzhUZsCWD?=
 =?us-ascii?Q?pfcQdS7wmcHxg8U7w5oyISs9MJ835sH+5ERyB3ZcsL3+ZT6fcR09fPkXnU7y?=
 =?us-ascii?Q?oqy4kTxc+P6X67cZQekGTwrYeCtJrSU+kpI3ReVc+XYBOv/bAKuWIp5kLmLm?=
 =?us-ascii?Q?L4fhlJO1UNYhrtjq+csjImO3TqSlnyuB4Gs9YdR8M9J8sw/TRntgX6i+yQWf?=
 =?us-ascii?Q?iGawA767P4vQQq3V4WioURfWyNIgSH/bP/Hghy8arkdhDJ0S0yTgNif7I82u?=
 =?us-ascii?Q?U/9wWVxgeYiVBNXAHRyYRq1hJ+rBIky7CzSMdIahRjRHrtqEZ745n1GLfsJ8?=
 =?us-ascii?Q?SpC3G/5R/hWcrD5nc70ZOX92e+bmWJIipMd2K6P6eW8HDEtVpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 05:08:30.6617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247d3418-1484-42e0-ab2b-08dcd60d9b4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587

Introduction
------------

This patch series adds a new "managed mode" to percpu-refcounts for
managing references for objects that are released after an RCU grace
period has passed since their last reference drop.

Typical usage pattern looks like below

// Called with elevated refcount
get()
    p = get_ptr();
    kref_get(&p->count);
    return p;

get()
    rcu_read_lock();
    p = get_ptr();
    if (p && !kref_get_unless_zero(&p->count))
        p = NULL;
    rcu_read_unlock();
    return p;

release()
    remove_ptr(p);
    call_rcu(&p->rcu, freep);

release()
    remove_ptr(p);
    kfree_rcu((p, rcu);

Requirement and Use Case
------------------------

Percpu refcount requires an explicit percpu_ref_kill() operation at the
object's usage site where the initial ref count is being dropped. For
optimal performance, the object's usage should reach a teardown point,
after which the references shouldn't be acquired or released frequently
before the final reference is dropped. Following the percpu_ref_kill(),
any refcount operations on the object are carried out on the
centralized atomic counter. The performance and scalability of those
usages decrease if the references are still being added or removed
after the percpu_ref_kill() operation because of the atomic counter's
cache line ping-pong between CPUs.

The throughput scalability issue that is seen when Nginx runs with the
AppArmor linux security module enabled is the primary motivation for
this change. Performance profiling shows that memory contention in the
atomic_fetch_add and atomic_fetch_sub operations carried out in
kref_get() and kref_put() operations on AppArmor labels accounts for
the majority of CPU cycles. Further information regarding the impact
of performance on Nginx throughput scalabilityand enhancements through
percpu references can be found in [1].

However, because of the way references are used in AppArmor, switching
from kref usage to per-cpu refcount was found to be non-trivial.

Although the specifics of AppArmor refcount management have already
been covered at [1], the explanation that follows aims to update that
information with more detailed (and hopefully more accurate)
information that support the requirement of managed percpu ref.

Within the AppArmor framework, label (struct aa_label) manages
references for different kinds of objects. Labels are associated with:
 - Profiles for applications.
 - Namespaces, via their unconfined profile.
 - Audit, secmark rules and compound labels.

Labels are referenced by file contexts, security contexts, secid,
sockets.

The diagram below illustrates the relationship between different
AppArmor objects via their label references.

                 ----------------
                | Root Namespace |
                 ----------------
                /   ^        |   ^
              (a)   |       (c)  |
              /    (b)       |  (d)
             v     /         v   |
       ------------        -----------------
      | Profile 1 |       | Child Namespace |
       ------------        -----------------
          |   ^               |    ^
         (e)  |              (g)   |
          |  (f)              |   (h)
          v   |               v    |
      ---------------       -----------
     | Child Profile |     | Profile 2 |   
      ---------------       -----------
                 ^           ^
                  \         /
                   \       /
                    \     /
                      (i)
                       |
                ----------------
               | Compound Label |
                ----------------

(a) The Root namespace keeps track of every profile that exists there.
    When a profile is loaded and unpacked, a reference to profile is
    taken for this. This reference to the profile object is also used
    its **init reference**.

(b) Root namespace is referenced by a profile that is part of it.

(c) To control confinement within a certain domain, such as a chroot
    environment, a root namespace may include child namespaces. Through
    each child namespace's unconfined label, the subnamespaces list in
    the root namespace maintains a (init) reference to child
    namespaces.

(d) A child namespace maintains a reference to its parent namespace.

(e) Profile can have child subprofiles which are called hat profiles.
    Certain program segments can be run with permissions differing
    from the base permissions using these profiles. For instance,
    executing user-supplied CGI programs in a different Apache profile,
    or running authorized and unauthenticated traffic in several
    OpenSSH profiles. By use of its policy profiles list, the parent
    profile maintains a reference to the child subprofiles. This serves
    as the child profile's init reference.

(f) Child profiles keep a reference to their parent profile.

(g) Child namespace keeps a reference to all  profiles in it.

(h) A reference to the parent non-root namespace is maintained by child
    profiles.

(i) Application of context-specific application confinement is done
    using compound/stack labels. When ls is started from bash, for
    instance, the confinement rules for the profile /bin/bash///bin/ls
    may differ from the system-level rules for ls execution. Compund
    labels are vector of profiles and maintain reference to every
    profile in its vector.

Label references
----------------

- Tasks are linked to labels via the security field of their cred. The
  cred label is copied from the parent task during the bprm exec's cred
  preparation, and the bprm is transitioned to the new label using the
  parent task's profile transition rules. A compound/stack label or the
  label of a single profile may be used in the transition depending on
  the perms rule for the bprm's path.

  When performing policy checks in AppArmor's security hooks for
  operations like file permissions, mkdir, rmdir, mount, and so on, the
  label linked to the task's cred is used. When the associated label is
  marked as stale, the cred label of a task can change (from within its
  context) while it is being executed.

  A task maintains references to previous labels for hat transitions,
  onexec labels, and nnp (no new privilege) labels for exec domain
  transition checks.

  Labels are cached in file context for file permissions checks on open
  files. As a result of task profile updates, this label is updated
  with new profiles from the task's current label during revalidations
  of cached file permissions.

- Socket contexts store the labels of the current task and peer.

- Profile fs maintains references to the label proxy and namespace in
  the inode->i_private fields.

- The label parsed from the rule string is referenced by Secmark rule
  objects.

- The label parsed from the rule string is referenced by audit rule
  objects.

Label's Initial Ref Teardown
----------------------------

- When a profile is deleted, the initial reference on its label is
  dropped and it is no longer a part of the parent namespace or
  parent profile. Furthermore, every one of its child profiles is
  deleted recursively. As a result, all profiles that are reachable
  from the base profile have their initial reference removed in a
  cascaded manner.

- When a namespace is destroyed, the initial reference to its
  unconfined label is dropped and it is removed from the parent
  namespace view. Furthermore, all profiles in that namespace,
  all sub namespaces, and all profiles inside those sub namespaces
  are recursively removed and their initial label reference is dropped.

- The reference to parent label is dropped with the release of a label
  reference post its last reference drop. A profile's parent profile
  and namespace references are dropped upon ref release. On the
  namespace ref release path, a namespace drops its reference to its
  parent namespace. As part of the label release, references to
  profiles in the compound label's vector are removed.

Stale Labels and Label Redirection
----------------------------------

- The label associated with profile/namespace that is deleted is marked
  as stale. When any profile of a compound label is stale, the compound
  label is also marked stale.

- Label's proxy is used to redirect stale labels to the most recent or
  active version of the object. For example, when a profile is deleted,
  its proxy is redirected to the unconfined label of the namespace. This
  indicates that every application that the profile confined has been
  moved to an unconfined profile. In a same manner, proxy is redirected
  to the new profile's label when a profile is replaced. The proxy of a
  namespace's unconfined label is redirected to the unconfined label of
  its parent namespace on namespace deletion.

  Redirection to new label is done during reference get operation:

  struct aa_label *aa_get_newest_label(struct aa_label *l)
  {
    struct aa_label __rcu **l = &l->proxy->label;
    struct aa_label *c;

    rcu_read_lock();
    do {
        c = rcu_dereference(*l);
    } while (c && !kref_get_unless_zero(&c->count));
    rcu_read_unlock();

    return c;
  }

Label reclaims
--------------

A label is completely initialized when it is linked to a namespace.
Label destruction is deferred until the end of a RCU grace period which
starts after the last reference drop. Enqueuing an RCU callback for
label and associated object destruction is done from the ref release
callback.

void aa_label_kref(struct kref *kref)
{
  struct aa_label *label = container_of(kref, struct aa_label, count);
  struct aa_ns *ns = labels_ns(label);

  if (!ns) {
    label_free_switch(label);
    return;
  }

  call_rcu(&label->rcu, label_free_rcu);
}

Using Label Stale operation for percpu_ref_kill()?
--------------------------------------------------

Marking a label as stale can serve as a reference termination point
since stale labels are redirected to the current label linked to its
objects. There are other labels, though, that are not associated with
namespaces or profiles. These labels are compound labels linked to
audit and secmark rule rules or running tasks that contain those
label references in their cred structure. These labels are:

- The label that is created from rule string is referenced by audit
  rules. It is possible that a multi element vector audit rule label
  already exists in the root labelset or that a new label is created
  during audit rule init. The reference is removed upon audit rule
  free. It's possible that the created label is actively referenced
  from other contexts, causing atomic contention on the label's ref
  operations if percpu_ref_kill() is called on audit rule free.

- The stacked labels which are created on profile exec/domain
  transitions are stored in task's cred structure. These labels are
  released when all tasks drop their cred reference to those labels.

- Transition labels which are created during change hat or change
  profile transitions could be referenced by multiple tasks. These
  labels are released when all tasks  drop their cred reference to
  those labels.

- Tasks' most recent label is combined with and cached in open file
  contexts. These cached labels don't have a defined termination point
  and can be actively referenced from multiple contexts.

- Other compound labels with similar ref lifetimes include pivotroot
  and secmark rules.

There exist further scenarios in which stale references may still be
referenced:

- Stale flags on labels are set using plain writes, and until the CPU
  observes the stale flag, new references may be incremented or
  decreased on the stale label.

- A task may make reference a namespace which is marked stale.

- Stale cred label, for which a proxy points to its namespace's stale
  unconfined label, the stale unconfined label can be referenced until
  the cred label is updated.

In summary, though percpuref kill can be used for labels when they are
maked stale, compound labels are not guaranteed to be marked stale
during their lifetime and they do not have a context where percpuref
kill can be done.

Proposed Solution
-----------------

The solution proposed here attempt to address the issue of
identifying the init reference drop context. A percpu ref manager
thread keeps an extra reference to the ref. This additional reference
is used as a (pseudo) init reference to the object. A percpu managed
ref instance offloads its ref's release work to the ref manager thread.

The ref manager thread uses the following sequence to periodically scan
the list of managed refs and determine whether a ref is active:

scan_ref() {
  bool active;

  percpu_ref_switch_to_atomic_sync(&ref);
  rcu_read_lock();
  percpu_ref_put(&ref);
  active = percpu_ref_tryget(&ref);
  rcu_read_unlock();
  if (active)
    percpu_ref_switch_to_percpu(&ref);
}

The sequence above drops the pseudo-init reference, converts the
reference to atomic mode, and verifies (within RCU read side
protection) that all references have been dropped. The reference
is switched back to perCPU mode (with the pseudo-init reference
obtained through the try operation) if there are any active
references.

The two approaches used in this patch series, with slightly differing
permitted ref mode switches and semantics, are listed below.

Approach 1
----------

Approach 1 is implemented in patch 1 and has below semantics for ref
init and switch.

a. Init

A ref can be set to managed mode at initialization time in
percpu_ref_init(), by passing the PERCPU_REF_REL_MANAGED flag, or by
calling percpu_ref_switch_to_managed() post init to switch a
reinitable ref to managed mode. Deferred switches are used in
situations like module initialization error, when the reference to
an inited reference is released before the object is used. One example
of this is the release of AppArmor labels which are not associated with a
namespace, which is done without waiting for RCU grace period.

Below are the allowed initialization modes for managed ref

               Atomic  Percpu   Dead  Reinit  Managed
Managed-ref       Y        N      Y      Y       Y

b. Switching modes and operations

Below are the allowed transitions for managed ref.

To -->       A    P    P(RI)    M    D   D(RI)   D(RI/M)    KLL    REI    RES

  A          y    n      y      y    n     y        y        y      y      y
  P          n    n      n      n    y     n        n        y      n      n    
  M          n    n      n      y    n     n        y        n      y      y
  P(RI)      y    n      y      y    n     y        y        y      y      y
  D(RI)      y    n      y      y    n     y        y        -      y      y
  D(RI/M)    n    n      n      y    n     n        y        -      y      y

Modes:
A - Atomic  P - PerCPU  M - Managed  P(RI) - PerCPU with ReInit
D(RI) - Dead with ReInit  D(RI/M) - Dead with ReInit and Managed

PerCPU Ref Ops:

KLL - Kill  REI - Reinit  RES - Resurrect

A percpu reference that has been switched to managed mode cannot be
switched back to any other active mode. Managed ref is reinitialized
to managed mode upon reinit/resurrect.

Approach 2
----------

The second approach provides a managed reference greater runtime mode
switching flexibility. This may be helpful in situations where the object
of a managed reference can enter a shutdown phase in some scenarios. For
example, for stale singular/compund labels, user can directly call
percpu_ref_kill() for the ref rather than waiting for the manager
thread to process the ref.

The init modes are the same as in the previous approach. Runtime mode
switching provides the ability to convert from managed mode to
unmanaged mode, hence enabling transitions to all reinitable modes.

To -->       A    P    P(RI)    M    D   D(RI)   D(RI/M)    KLL    REI    RES

  A          y    n      y      y    n     y        y        y      y      y
  P          n    n      n      n    y     n        n        y      n      n    
  M          y*   n      y*     y    n     y*       y        y*     y      y
  P(RI)      y    n      y      y    n     y        y        y      y      y
  D(RI)      y    n      y      y    n     y        y        -      y      y
  D(RI/M)    y*   n      y*     y    n     y*       y        -      y      y

(RI) refers to modes whose initialization was done using
PERCPU_REF_ALLOW_REINIT. The aforementioned transitions are permitted
and may be indirect transitions. For example, when
percpu_ref_switch_to_unmanaged() is invoked for it, managed ref
switches to P(RI) mode. percpu_ref_switch_to_atomic() can be used to
switch from P(RI) mode to A mode.

Design Implications
-------------------

1. Deferring the release of a referenced object to the manager thread
   may delay its memory release. This can result in memory pressure.
   By turning a managed reference to an unmanaged ref and then
   executing percpu_ref_kill() on it at known shutdown points in
   the execution, this issue can be partially resolved using the
   second approach.

   Flush the scanning work on memory pressure is another strategy that
   can be used.

2. call_rcu_hurry() is used by percpu refcount lib to perform mode
   switch operations. Back to back hurry callbacks can impact energy
   efficiency. The current implementation allows moving the execution
   to housekeeping cores by using an unbounded workqueue. A deferrable
   timer can be used to prevent these invocations when the core is
   idle by delaying the worker execution. Deferring, though, may cause
   ref reclaims to be delayed.

3. Since the percpu refcount lib uses a single global switch spinlock,
   back-to-back label switches can delay other percpu users.

4. Long running kworkers may cause other use cases, such as system
   suspend, to be delayed. By using a freezable work queue and limiting
   node scans to a maximum count, this is mitigated.

5. Because all managed refs undergo switch-to-atomic mode operation
   serially, an inactive ref must wait for all prior grace periods to
   complete before it can be assessed. Ref release may be greatly
   delayed as a result of this. Batching ref switches can be one
   method to deal with this, ensuring that all of those RCU callbacks
   are completed by single grace period.

6. A label's refcount can operate in atomic mode within the window
   while its counter is being checked for zero. This could lead to
   high memory contention within the RCU grace period (together with
   callback execution) duration. In AppArmor, all application that use
   unconfined profiles will execute atomic ref increment and decrement
   operations on the ref during that window if the currently scanned
   label belongs to an unconfined profile. In order to handle this,
   a prototype is described and implemented in [1], which replaces the
   atomic and percpu counters of the scanned ref with a temporary
   percpu ref. Given that the grace period window is of small duration
   (compared to the scan interval), overall impact of this might not be
   significant enough to consider the massive complexity of that
   prototype implementation. This problem requires more investigation
   in order to find a simpler solution.

Extended/Future Work
--------------------

1. Another design approach, which was considered was to define a new
   percpu rcuref type for RCU managed percpu refcounts. This approach
   is prototyped in [1]. Although this approach provides cleaner
   semantics w.r.t. mode switches and allowed operations, its current
   implementation, using composition of percpu ref, could be suboptimal
   in terms of  the struct's cacheline space requirement and feature
   extensibility. An independent implementation would require
   refactoring of the common logic out of the percpu refcount
   implementation. Additionally, the users of new api could require
   the modes (ex. ref kill/reinit) supported by percpu refcount.
   Extending percpu rcuref to support this can result in duplication
   of functionality/semantics between the two percpu ref types.

2. Explore hazard pointers for scalable refcounting of objects, which
   provides a more generic solution and has more efficient memory
   space requirements.

Below is the organization of the patches in this series:

1. Implementation of first approach described in "Proposed Solution"
   section.

2. Torture test for managed ref to validate early ref release and
   imbalanced refcount.

   The test is verified on AMD 4th Generation EPYC Processor wth 96C/192T
   with following test parameters:

   nusers = 300
   nrefs = 50
   niterations = 50000
   onoff_holdoff = 5
   onoff_interval = 10

3. Implementation of second approach described in "Proposed Solution"
   section.

4. Updates to torture test to test runtime mode switches from managed
   to unmanaged modes.

5. Switch Label refcount management to percpu ref in atomic mode.

6. Switch Label refcount management to managed mode.

Highly appreciate any feedback/suggestions on the design approach.


[1] https://lore.kernel.org/lkml/20240110111856.87370-7-Neeraj.Upadhyay@amd.com/T/

- Neeraj

Neeraj Upadhyay (6):
  percpu-refcount: Add managed mode for RCU released objects
  percpu-refcount: Add torture test for percpu refcount
  percpu-refcount: Extend managed mode to allow runtime switching
  percpu-refcount-torture: Extend test with runtime mode switches
  apparmor: Switch labels to percpu refcount in atomic mode
  apparmor: Switch labels to percpu ref managed mode

 .../admin-guide/kernel-parameters.txt         |  69 +++
 include/linux/percpu-refcount.h               |  14 +
 lib/Kconfig.debug                             |   9 +
 lib/Makefile                                  |   1 +
 lib/percpu-refcount-torture.c                 | 404 ++++++++++++++++++
 lib/percpu-refcount.c                         | 329 +++++++++++++-
 lib/percpu-refcount.h                         |   6 +
 security/apparmor/include/label.h             |  16 +-
 security/apparmor/include/policy.h            |   8 +-
 security/apparmor/label.c                     |  12 +-
 security/apparmor/policy_ns.c                 |   2 +
 11 files changed, 836 insertions(+), 34 deletions(-)
 create mode 100644 lib/percpu-refcount-torture.c
 create mode 100644 lib/percpu-refcount.h

-- 
2.34.1

